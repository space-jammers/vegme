require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do
  let(:user) { User.create!(email: 'me@here.com', password: 'sdkjh59sda') }

  describe 'new' do
    it 'requires the user to be logged in' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it 'successfully shows the new feedback form' do
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'create' do
    it 'requires the user to be logged in' do
      post :create, params: {
        feedback: {
          label: 'My Label',
          message: 'Fix it',
          link: 'vegme.com/queries',
          user_id: 1,
          complete: false
        }
      }
      expect(response).to redirect_to new_user_session_path
    end

    it 'allows a signed in user to create a feedback' do
      sign_in user
      post :create, params: {
        feedback: {
          label: 'My Label',
          message: 'Fix it',
          link: 'vegme.com/queries',
          user_id: user.id,
          complete: false
        }
      }

      feedback = Feedback.last
      expect(feedback.label).to eq('My Label')
      expect(feedback.user_id).to eq(user.id)
    end

    context 'when the feedback is valid' do
      let!(:email_count) { ActionMailer::Base.deliveries.count }
      let!(:flash_count) { flash.count }
      before(:each) do
        sign_in user
        post :create, params: {
          feedback: {
            label: 'My Label',
            message: 'Fix it',
            link: 'vegme.com/queries',
            user_id: user.id,
            complete: false
          }
        }
      end

      it 'sends an email to the admins about the feedback' do
        expect(ActionMailer::Base.deliveries.count).to eq(email_count + 1)
      end

      it 'shows a flash message' do
        expect(flash.count).to eq(flash_count + 1)
        expect(flash[:success]).to match('Thanks for your feedback!')
      end

      it 'reqirects to queries_path' do
        expect(response).to redirect_to queries_path
      end
    end

    context 'when the feedback is invalid' do
      it 'should properly deal with validation errors' do
        feedback_count = Feedback.count

        sign_in user
        post :create, params: {
          feedback: {
            label: '',
            message: 'Fix it',
            link: 'vegme.com/queries',
            user_id: user.id,
            complete: false
          }
        }

        expect(Feedback.count).to eq(feedback_count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'update'
end
