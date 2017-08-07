class QueriesController < ApplicationController
  require 'tasks/get_recipes'
  require 'tasks/query_result'
  require 'tasks/recipe_errors'

  def index
    return flash.now[:notice] = 'API limit reached' if
    QueryResult.api_limit? || RecipeErrors.api_limit?
    return flash.now[:notice] = 'error' if QueryResult.query_error?
    return flash.now[:notice] = 'no recipe found' if QueryResult.no_recipe_found?
    return unless QueryResult.hits
    @recipes = if signed_in?
                 QueryResult.filter_hits(current_user.disliked_recipes,
                                         QueryResult.hits).paginate(params[:page],
                                                                    params[:anchor],
                                                                    9)
               else
                 QueryResult.hits.paginate(params[:page],
                                           params[:anchor],
                                           9)
               end
    respond_to do |format|
      format.html
      format.json { render json: @recipes }
    end
  end

  def search
    new_recipes = first_call
    store(new_recipes.search)
    redirect_to queries_path
  end
end

private

def first_call
  GetRecipes.new(params[:q],
                 params[:max_cal],
                 params[:health])
end

def store(recipe_search)
  QueryResult.store_query_result(recipe_search,
                                 params[:q],
                                 params[:max_cal],
                                 params[:health])
end
