class RecipesController < ApplicationController
  require 'tasks/recipe_errors'

  def show
    recipe = if params[:name]
               Recipe.new(name: params[:name], edamam_id: params[:id])
             else
               Recipe.find_by_id(params[:id])
             end

    if recipe
      @recipe = RecipesHelper.recipe_dto_from_api(recipe)
      redirect_to root_path if RecipeErrors.api_limit?
    else
      # can redirect back to user dashboard once implemented for favorites,
      # user dashboard for saved recipes
      redirect_to action: 'show', id: 1, status: :not_found
    end
  end

  def create
    @recipe = Recipe.create(name: params[:name], edamam_id: params[:id])
    redirect_to recipe_path(@recipe.id)
  end

  def destroy
    @recipe = Recipe.find_by(edamam_id: params[:id])
    @recipe.delete
    redirect_to root_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :edamam_id)
  end
end
