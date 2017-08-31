class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[create show destroy]
  before_action :require_authorized_for_current_recipe, only: %i[show destroy]
  def show
    recipe = current_recipe
    if recipe
      @recipe = recipe_dto_from_api(recipe)
      redirect_to queries_path if RecipeErrors.api_limit?
    else
      redirect_to dashboard_path, status: :not_found
    end
  end

  def create
    Recipe.create(name: params[:recipe_name],
                  edamam_id: params[:id],
                  dislike: params[:dislike],
                  image: params[:image],
                  user_id: current_user.id)
  end

  def destroy
    recipe = current_recipe
    return render status: :forbidden if recipe.user_id != current_user.id
    recipe.destroy
  end

  private

  def require_authorized_for_current_recipe
    return if current_recipe.nil?
    return if current_user.admin
    return if current_recipe.user_id == current_user.id
    flash[:error] = 'Oops! That page is restricted'
    redirect_to root_path
  end

  def current_recipe
    Recipe.find_by_id(params[:id])
  end

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
