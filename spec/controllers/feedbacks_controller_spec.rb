require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do
  let(:user) { User.create!(email: 'me@here.com', password: 'sdkjh59sda') }

  describe 'new' do
    it 'redirects an unathenticated user to the sign in page' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it 'allows an authenticated user to access the new feedback form' do
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'create' do
    context 'for an unathenticated user' do
      it 'redirects the user to the sign in page' do
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
    end

    context 'for an authenticated user' do
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

        it 'sends an email to the admins' do
          expect(ActionMailer::Base.deliveries.count).to eq(email_count + 1)
        end

        it 'shows a flash message' do
          expect(flash.count).to eq(flash_count + 1)
        end

        it 'redirects to queries_path' do
          expect(response).to redirect_to queries_path
        end
      end

      context 'when the feedback is invalid' do
        let!(:feedback_count) { Feedback.count }
        before(:each) do
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
        end

        it 'does not create the invalid feedback' do
          expect(Feedback.count).to eq(feedback_count)
        end

        it 'renders unprocessable_entity status upon creation attempt' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'renders the new template upon creation attempt' do
          expect(response).to render_template(:new)
        end
      end
    end
  end
end
