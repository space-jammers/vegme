class QueriesController < ApplicationController
  require 'tasks/get_recipes'
  require 'tasks/query_result'
  require 'tasks/recipe_errors'

  def index
    query = QueryResult.recent
    return flash.now[:notice] = 'API limit reached' if
      query.api_limit? || RecipeErrors.api_limit?
    return flash.now[:notice] = 'error' if query.query_error?
    return flash.now[:notice] = 'no recipe found' if query.no_recipe_found?
    return unless query.hits
    @recipes = if signed_in?
                 query.filter_hits(current_user.disliked_recipes,
                                         query.hits).paginate(params[:page],
                                                                    params[:anchor],
                                                                    9)
               else
                 query.hits.paginate(params[:page],
                                           params[:anchor],
                                           9)
               end
    respond_to do |format|
      format.html
      format.json { render json: @recipes }
    end
  end

  def limbo
    render json: QueryResult.recent
  end

  def search
    new_recipes = first_call
    if empty_query?
      flash[:alert] = 'Oops! Looks like the search field was empty, please try again!'
    else
      store(new_recipes.search)
    end
    redirect_to queries_path
  end
end

private

def first_call
  GetRecipes.new(params[:q],
                 params[:max_cal],
                 params[:health])
end

def empty_query?
  /^\s*$/ =~ params[:q].to_s
end

def store(recipe_search)
  QueryResult.new(recipe_search,
                  params[:q],
                  params[:max_cal],
                  params[:health])
end
