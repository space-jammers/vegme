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
                 QueryResult.filter_hits(current_user.disliked_recipes, clean_hits)
               else
                 clean_hits
               end
  end

  def search
    new_recipes = first_call
    store(new_recipes.search)
    QueryResult.filter_violation_recipes(params[:health])
    redirect_to root_path
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
                                 params[:max_cal])
end

def clean_hits
  QueryResult.hits_without_violations(
    QueryResult.return_violations,
    QueryResult.hits
  )
end
