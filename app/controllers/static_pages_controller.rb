class StaticPagesController < ApplicationController
  require 'tasks/recipe_query'
  require 'tasks/query_result'

  def index
    if QueryResult.query_error?
      flash.now[:notice] = 'error'
    else
      @recipes = QueryResult.return_query_result
    end
  end

  def search
    new_recipes = RecipeQuery.new(params[:q],
                                  params[:limit],
                                  params[:health])
    QueryResult.store_query_result(new_recipes.search, params[:q])
    redirect_to root_path
  end
end
