class StaticPagesController < ApplicationController
  require 'recipe'
  require 'recipe_data'
  def index
    @new_recipes = Recipe.new('apples', 3, 'vegetarian')
    @recipes = RecipeData.new(@new_recipes.search)
    @recipes_with_calories = @recipes.each_recipe('calories')
  end
end
