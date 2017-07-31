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
    new_recipes = first_call(params[:limit])
    store(new_recipes.search)
    disliked = check_dislikes
    return if disliked.nil?
    second_call(disliked)
    redirect_to root_path
  end
end

private

def check_dislikes
  return nil if current_user.disliked_recipes.nil?
  disliked = QueryResult.disliked_in_results(current_user.disliked_recipes,
                                             QueryResult.hits)
  return nil if disliked.nil?
  disliked
end

def second_call(disliked)
  compare = QueryResult.compare_hits(QueryResult.num_of_hits, disliked)
  new_limit = signed_in? ? (params[:limit].to_i + compare.to_i) : nil
  filtered_recipes = first_call(params[:limit], new_limit)
  store(filtered_recipes.search)
end

def first_call(limit, new_limit = nil)
  GetRecipes.new(params[:q],
                 new_limit ? new_limit : limit,
                 params[:max_cal],
                 params[:health])
end

def store(recipe_search)
  QueryResult.store_query_result(recipe_search,
                                 params[:q],
                                 params[:limit],
                                 params[:max_cal])
end
