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

  describe 'update' do
    let(:feedback) do
      Feedback.create(label: 'My label',
                      message: 'Fix it',
                      link: 'vegme.com/queries',
                      user_id: user.id,
                      complete: false)
    end

    context 'when an admin is signed in' do
      it 'should allow the admin to update the feedback' do
        sign_in admin
        put :update, params: { id: feedback.id, feedback: { message: 'New message' } }
        feedback.reload
        expect(feedback.message).to eq('New message')
      end

      it 'should render not_found if the feedback does not exist' do
        sign_in admin
        put :update, params: { id: 'fake', feedback: { message: 'New message' } }
        feedback.reload
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when an admin is not signed in' do
      it 'should not allow a non-admin user to update the feedback' do
        sign_in user
        put :update, params: { id: feedback.id, feedback: { message: 'New message' } }
        feedback.reload
        expect(feedback.message).to eq('Fix it')
      end

      it 'should not allow a non signed in user to update the feedback' do
        put :update, params: { id: feedback.id, feedback: { message: 'New message' } }
        feedback.reload
        expect(feedback.message).to eq('Fix it')
      end
    end
  end
end
