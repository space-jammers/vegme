class StaticPagesController < ApplicationController
  require 'recipe'
  def index
    @recipes = Recipe.return_query()
  end

  def create_recipe
    new_recipes = Recipe.new(params[:q],
                             params[:limit],
                             params[:health])
    Recipe.store_query(new_recipes.search)
    redirect_to root_path
  end
end
