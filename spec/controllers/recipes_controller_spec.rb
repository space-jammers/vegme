require 'rails_helper'
require 'tasks/get_recipe'
require 'tasks/recipe_dto'

RSpec.describe RecipesController, type: :controller do
  describe 'show' do
    subject(:blueberry_pie) do
      Recipe.create(name: 'Blueberry Pie', edamam_uri:
      'http://www.edamam.com/ontologies/edamam.owl#
      recipe_364de010f901bb12a86698aa936adb8f')
    end

    it 'shows a recipe if the recipe is found' do
      get :show, params: { id: blueberry_pie.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns a 404 error if the recipe is not found' do
      get :show, params: { id: 'Blue' }
      expect(response).to have_http_status(:not_found)
    end
  end
end
