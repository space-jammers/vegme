class QueryController < ApplicationController
  require 'recipe'

  def index
    query = Query.last
    @recipes = query.payload
  end

  def new
    @query = Query.new
  end

  def create
    new_recipes = Recipe.new(query_params[:query_term],
                             query_params[:results_limit],
                             query_params[:health])

    @recipes = new_recipes.search

    @query = Query.create(query_params) do |q|
      q.payload = @recipes
    end
    redirect_to query_index_url
  end

  private

  def query_params
    params.require(:query).permit(:query_term, :results_limit, :health, :payload)
  end
end
