class RecipesController < ApplicationController
  before_action :authenticate_user_or_admin!, only: %i[create show destroy]
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
    current_user.recipes.create(name: params[:recipe_name],
                                edamam_id: params[:id],
                                dislike: params[:dislike],
                                image: params[:image])
  end

  def destroy
    @recipe = current_user.recipes.find_by(id: params[:id])
    @recipe.destroy
  end

  private

  def recipe_params
    params.permit(:name, :edamam_id, :dislike, :image)
  end

  def recipe_dto_from_api(recipe_data)
    recipe_call = GetRecipe.new(recipe_data.edamam_id)
    recipe = recipe_call.find_recipe
    RecipeErrors.store_api_result(recipe)
    RecipeErrors.api_limit? ? return : RecipeDto.new(recipe[0])
  end
end
