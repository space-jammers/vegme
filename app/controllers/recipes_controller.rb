class RecipesController < ApplicationController
  before_action :authenticate_user_or_admin!, only: %i[create show destroy]

  def new
    Recipe.new
  end

  def show
    recipe = current_user.recipes.find_by_id(params[:id])
    if recipe
      @recipe = recipe_dto_from_api(recipe)
      redirect_to queries_path if RecipeErrors.api_limit?
    else
      redirect_to dashboard_path, status: :not_found
    end
  end

  def create
    @recipe = current_user.recipes.create(recipe_params)
  end

  def destroy
    @recipe = current_user.recipes.find_by(id: params[:id])
    @recipe.destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :edamam_id, :dislike, :image)
  end

  def recipe_dto_from_api(recipe_data)
    recipe_call = GetRecipe.new(recipe_data.edamam_id)
    recipe = recipe_call.find_recipe
    RecipeErrors.store_api_result(recipe)
    RecipeErrors.api_limit? ? return : RecipeDto.new(recipe[0])
  end
end
