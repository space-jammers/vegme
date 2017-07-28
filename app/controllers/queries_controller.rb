class QueriesController < ApplicationController
  # require 'queries_helper'
  require 'tasks/get_recipes'
  require 'tasks/query_result'
  require 'tasks/recipe_errors'

  def index
    return flash.now[:notice] = 'API limit reached' if
    QueryResult.api_limit? || RecipeErrors.api_limit?
    return flash.now[:notice] = 'error' if QueryResult.query_error?
    return flash.now[:notice] = 'no recipe found' if QueryResult.no_recipe_found?
    @recipes = QueryResult.filter_dislikes_from_results(disliked_recipes,
                                                        QueryResult.hits)
  end

  def search
    new_recipes = GetRecipes.new(params[:q],
                                 params[:limit],
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

def disliked_recipes
  current_user.recipes.where(dislike: true).select('name').map(&:name).to_a
end
