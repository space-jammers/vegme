class RecipesController < ApplicationController
  require 'tasks/get_recipe'
  require 'tasks/recipe_dto'

  def show
    my_recipe = Recipe.find_by_id(params[:id])
    if my_recipe
      recipe_call = GetRecipe.new(my_recipe.edamam_uri)
      @recipe = recipe_call.find_recipe[0]
      puts @recipe.inspect
      @recipe_dto = RecipeDto.new(@recipe)
    else
      render status: :not_found
    end
  end
end
