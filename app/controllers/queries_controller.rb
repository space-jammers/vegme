class QueriesController < ApplicationController
  # require 'queries_helper'
  require 'tasks/get_recipes'
  require 'tasks/query_result'

  def index
    return flash.now[:notice] = 'error' if QueryResult.query_error?
    return flash.now[:notice] = 'no recipe found' if QueryResult.no_recipe_found?

    @recipes = QueryResult.hits
  end

  def search
    new_recipes = GetRecipes.new(params[:q],
                                 params[:limit],
                                 params[:max_cal],
                                 params[:health])
    QueryResult.store_query_result(new_recipes.search, params[:q])
    redirect_to queries_path
  end
end
