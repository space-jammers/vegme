class StaticPagesController < ApplicationController
  require 'recipe'
  def index
    new_recipes = Recipe.new('apples', 3, 'vegetarian')
    @recipes = new_recipes.search
  end
end
