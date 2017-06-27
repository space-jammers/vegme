class QueryController < ApplicationController
  require 'recipe'
  def index
    query = Query.last
    new_recipes = Recipe.new(query.query_term, query.results_limit, query.health)
    @recipes = new_recipes.search
  end

  def new
    @query = Query.new
  end

  def create
    @query = Query.create(query_params)
    redirect_to query_index_url
  end

  private

  def query_params
    params.require(:query).permit(:query_term, :results_limit, :health)
  end
end
