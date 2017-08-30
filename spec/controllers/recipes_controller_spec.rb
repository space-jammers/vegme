require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  let(:user1) { User.create!(email: 'me@here.com', password: 'sdkjh59sda') }
  let(:user2) { User.create!(email: 'you@there.com', password: 'uihsfd87yD') }
  let(:admin) { User.create!(email: ENV['hm_email'], password: 's36kjh59sda') }
  let(:eggplant) do
    Recipe.create(user_id: user1.id,
                  name: 'Spicy Eggplant',
                  edamam_id:'http://www.edamam.com/ontologies/edamam.owl#recipe_a53ef6c8495adcb9f2859b1e5d99e9ba')
  end

  describe 'show' do
    it 'returns a success status if the recipe is found' do
      sign_in user1
      get :show, params: { id: eggplant.id }
      allow(controller).to receive(:recipe_dto_from_api)
      expect(response).to have_http_status(:success)
    end

    it 'returns a 404 error if the recipe is not found' do
      sign_in user1
      get :show, params: { id: 'Blue' }
      allow(controller).to receive(:recipe_dto_from_api)
      expect(response).to have_http_status(:not_found)
    end

    # it 'allows an admin to view a user\s recipe' do
    #   sign_in admin
    #   allow(controller).to receive(:recipe_dto_from_api)
    #   get :show, params: { user_id: user1.id, id: eggplant.id }
    #   expect(response).to have_http_status(:success)
    # end
  end

  describe 'create' do
    it 'should allow a signed in user to create a recipe' do
      sign_in user1
      post :create, params: {
        user_id: user1.id,
        recipe_name: 'Nachos',
        id: 'edamam.com/nachos',
        dislike: false,
        image: 'nachos_photo'
      }
      expect(user1.recipes.last.name).to eq('Nachos')
    end

    it 'should not allow an unauthenticated user to create a recipe' do
      post :create, params: {
        user_id: user1.id,
        recipe_name: 'Nachos',
        id: 'edamam.com/nachos',
        dislike: false,
        image: 'nachos_photo'
      }
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'destroy' do
    it 'allows an authenticated user to destroy a recipe they created' do
      sign_in user1
      delete :destroy, params: { id: eggplant.id }
      user1.recipes.reload
      expect(user1.recipes).not_to include(eggplant)
    end

    it 'does not allow an unauthenticated user to destroy a recipe' do
      delete :destroy, params: { id: eggplant.id }
      user1.recipes.reload
      expect(user1.recipes).to include(eggplant)
    end
  end
end
