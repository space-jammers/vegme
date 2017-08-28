# was the web request successful?
# was the user redirected to the right page?
# was the user successfully authenticated?
# was the correct object stored in the response template?
# was the appropriate message displayed to the user in the view?

require 'rails_helper'
RSpec.describe QueriesController, type: :controller do
  describe 'index' do
    context 'query has not been made yet' do
      it 'returns the queries#index page' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context 'valid query has been made by an authenticated user' do
      it 'returns the queries#index page with results' do
      end
    end

    context 'valid query has been made by an unathenticated user' do
      it 'returns the queries#index page with results ' do
      end
    end

    context 'query with errors has been made' do
      it 'returns flash message if error exists' do
      end
    end
  end


  describe 'search' do
    it 'returns query results' do
    end

    it 'redirects_to queries#index' do
    end
  end

  describe 'api_call' do
  end

  describe 'empty_query' do
  end

  describe 'store' do
  end

  describe 'flash_errors' do
  end

  describe 'filter' do
  end

  describe 'un_filtered' do
  end

  describe 'verify_call' do
  end

end
