# was the web request successful?
# was the user redirected to the right page?
# was the user successfully authenticated?
# was the correct object stored in the response template?
# was the appropriate message displayed to the user in the view?

require 'rails_helper'
file = File.read('spec/three_pizza_query.json')
data_hash = JSON.parse(file)

RSpec.describe QueriesController, type: :controller do
  describe 'index' do
    let(:user) { User.create!(email: 'dolphin@here.com', password: 'sdkjh59sda') }

    context 'query has not been made yet' do
      it 'returns the queries#index page' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context 'valid query has been made by an authenticated user' do
      it 'returns the queries#index page with results' do
        sign_in user
        get :index
        allow(controller).to receive(:filter).with(data_hash)
        expect(response).to have_http_status(:success)
      end
    end

    context 'valid query has been made by an unathenticated user' do
      it 'returns the queries#index page with results' do
        sign_in user
        get :index
        allow(controller).to receive(:unfiltered).with(data_hash)
        expect(response).to have_http_status(:success)
      end
    end

    context 'query with errors has been made' do
      it 'returns flash notice if api limit reached' do
        get :index
        allow(controller).to receive(:flash_errors)
          .with(401)
          .and_return(flash.now[:notice] = 'API limit reached')
        expect(flash.now[:notice]).to be_present
      end

      it 'returns flash error if error occurs' do
        get :index
        allow(controller).to receive(:flash_errors)
          .with(403)
          .and_return(flash.now[:error] = 'error')
        expect(flash.now[:error]).to be_present
      end

      it 'returns flash notice if results are blank' do
        get :index
        allow(controller).to receive(:flash_errors)
          .with('count' => 0)
          .and_return(flash.now[:notice] = 'no recipe found')
        expect(flash.now[:notice]).to be_present
      end
    end
  end

  describe 'search' do
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
