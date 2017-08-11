
class QueriesController < ApplicationController
  require 'tasks/get_recipes'
  require 'tasks/query_result'
  require 'tasks/recipe_errors'

  def index
    @term = params[:q]
    @max = params[:max_cal]
    @health = params[:health]
    query = QueryResult.recent(params[:search_id])
    return unless query
    flash_errors(query)
    return unless query.hits
    @recipes = if signed_in?
                 query.filter_hits(current_user.disliked_recipes,
                                   query.hits).paginate(params[:page],
                                                        params[:anchor],
                                                        9)
               else
                 query.hits.paginate(params[:page], params[:anchor], 9)
               end
    respond_to do |format|
      format.html
      format.json { render json: @recipes }
    end
  end

  def limbo
    render json: QueryResult.all_keys
  end

  def search
    QueryResult.remove(params[:old_id])
    new_recipes = api_call
    if empty_query?
      flash[:alert] = 'Oops! Looks like the search field was empty, please try again!'
    else
      store(new_recipes.search)
    end
    redirect_to queries_path(search_id: params[:search_id],
                             q: params[:q],
                             max_cal: params[:max_cal],
                             health: params[:health])
  end

  private

  def api_call
    GetRecipes.new(params[:q],
                   params[:max_cal],
                   params[:health])
  end

  def empty_query?
    /^\s*$/ =~ params[:q].to_s
  end

  def store(recipe_search)
    QueryResult.new(recipe_search,
                    params[:search_id])
  end

  def flash_errors(query)
    return flash.now[:notice] = 'API limit reached' if
      query.api_limit? || RecipeErrors.api_limit?
    return flash.now[:notice] = 'error' if query.query_error?
    return flash.now[:notice] = 'no recipe found' if query.no_recipe_found?
  end
end
