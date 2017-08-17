require 'rails_helper'
# file = File.read('spec/spicy_eggplant.json')
# data_hash = JSON.parse(file)[0]

RSpec.describe RecipesController, type: :controller do
  describe 'show' do
    let(:user) { User.create!(email: 'me@here.com', password: 'sdkjh59sda') }
    let(:eggplant) do
      user.recipes.create(name: 'Spicy Eggplant', edamam_id:
      'http://www.edamam.com/ontologies/edamam.owl#recipe_a53ef6c8495adcb9f2859b1e5d99e9ba')
    end

    it 'returns a success status if the recipe is found' do
      sign_in user
      allow(controller).to receive(:recipe_dto_from_api)
      get :show, params: { user_id: user.id, id: eggplant.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns a 404 error if the recipe is not found' do
      sign_in user
      get :show, params: { user_id: user.id, id: 'Blue' }
      expect(response).to have_http_status(:not_found)
    end
  end
end
