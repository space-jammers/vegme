require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  let(:user) { User.create!(email: 'me@here.com', password: 'sdkjh59sda') }
  let(:admin) { User.create!(email: ENV['hm_email'], password: 's36kjh59sda') }

  describe 'show' do
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
      allow(controller).to receive(:recipe_dto_from_api)
      get :show, params: { user_id: user.id, id: 'Blue' }
      expect(response).to have_http_status(:not_found)
    end

    # it 'allows an admin to view a user\s recipe' do
    #   sign_in admin
    #   allow(controller).to receive(:recipe_dto_from_api)
    #   get :show, params: { user_id: user.id, id: eggplant.id }
    #   expect(response).to have_http_status(:success)
    # end
  end

  describe 'create' do
    # it 'should allow a signed in user to create a recipe' do
    #   sign_in user
    #   post :create, params: {
    #     user_id: user.id,
    #     name: 'Nachos',
    #     edamam_id: 'edamam.com/nachos',
    #     dislike: false,
    #     image: 'nachos_photo'
    #   }
    #   puts user.recipes.last.inspect
    #   expect(user.recipes.last.dislike).to eq(false)
    # end

    it 'should not allow an unauthenticated user to create a recipe' do
      post :create, params: {
        user_id: user.id,
        name: 'Nachos',
        edamam_id: 'edamam.com/nachos',
        dislike: false,
        image: 'nachos_photo'
      }
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'destroy' do
    # it 'allows an authenticated user to destroy a recipe they created'
    # it 'does not allow an unauthenticated user to destroy a recipe'
    # it 'does not allow an authenticated user to destroy another user\'s recipe'
  end
end
