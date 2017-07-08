class StaticPagesController < ApplicationController
  require 'tasks/recipe_query'
  require 'tasks/query_result'

  def index
    @recipes = QueryResult.return_query_result
  end

  def search
    new_recipes = RecipeQuery.new(params[:q],
                                  params[:limit],
                                  params[:health])
    QueryResult.store_query_result(new_recipes.search, params[:q])
    redirect_to root_path
  end
end
