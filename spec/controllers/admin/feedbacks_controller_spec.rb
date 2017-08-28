require 'rails_helper'

RSpec.describe Admin::FeedbacksController, type: :controller do
  let(:user) { User.create!(email: 'me@here.com', password: 'sdkjh59sda') }
  let(:admin) { User.create!(email: ENV['hm_email'], password: 's36kjh59sda') }

  describe 'index' do
    it 'allows a signed in admin to access the page' do
      sign_in admin
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'does not allow a non-admin user to access the page' do
      sign_in user
      get :index
      expect(response).to redirect_to root_path
    end

    it 'does not allow a user who isn\'t signed in to access the page' do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'update'
end
