# was the web request successful?
# was the user redirected to the right page?
# was the user successfully authenticated?
# was the correct object stored in the response template?
# was the appropriate message displayed to the user in the view?

require 'rails_helper'
RSpec.describe DashboardsController, type: :controller do
  let(:user) { User.create!(email: 'monkey@here.com', password: 'sdkjh59sda') }

  describe 'show' do
    it 'returns dashboard#show for authenticated user' do
      sign_in user
      get :show
      expect(response).to have_http_status(:success)
    end

    it 'does not allow an unathenticated user access' do
      get :show
      expect(response).to have_http_status(302)
    end

    it 'redirects an unathenticated user to the sign in page' do
      get :show
      expect(response).to redirect_to new_user_session_path
    end

    it 'flashes a message to the unathenticated user' do
      get :show
      expect(subject.request.flash[:alert]).to_not be_nil
    end
  end
end
