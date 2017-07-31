class QueriesController < ApplicationController
  require 'tasks/get_recipes'
  require 'tasks/query_result'
  require 'tasks/recipe_errors'

  def index
    return flash.now[:notice] = 'API limit reached' if
    QueryResult.api_limit? || RecipeErrors.api_limit?
    return flash.now[:notice] = 'error' if QueryResult.query_error?
    return flash.now[:notice] = 'no recipe found' if QueryResult.no_recipe_found?
    @recipes = if signed_in?
                 QueryResult.filter_hits(current_user.disliked_recipes, QueryResult.hits)
               else
                 QueryResult.hits
               end
  end

  def search
    new_limit = params[:limit].to_i + temp_search_comparison.to_i if signed_in?
    new_recipes = GetRecipes.new(params[:q],
                                 new_limit ? new_limit : params[:limit],
                                 params[:max_cal],
                                 params[:health])

    QueryResult.store_query_result(new_recipes.search,
                                   params[:q],
                                   params[:limit],
                                   params[:max_cal])
    redirect_to root_path
  end
end

private

def temp_search_comparison
  temp_api_call = GetRecipes.new(params[:q],
                                 params[:limit],
                                 params[:max_cal],
                                 params[:health])
  QueryResult.store_query_result(temp_api_call.search,
                                 params[:q],
                                 params[:limit],
                                 params[:max_cal])
  disliked = QueryResult.disliked_in_results(current_user.disliked_recipes,
                                             QueryResult.hits)
  QueryResult.compare_hits(QueryResult.num_of_hits, disliked)
end
