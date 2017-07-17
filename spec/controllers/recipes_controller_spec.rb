require 'rails_helper'
require 'tasks/get_recipe'
require 'tasks/recipe_dto'

RSpec.describe RecipesController, type: :controller do
  describe 'show' do
    subject(:blueberry_pie) do
      Recipe.create(name: 'Blueberry Pie', edamam_uri:
      'http://www.edamam.com/ontologies/edamam.owl#
      recipe_364de010f901bb12a86698aa936adb8f')
    end

    let(:options) {
      "https://api.edamam.com/search?
      app_id=#{ENV['app_id']}&
      app_key=#{ENV['app_key']}&
      r=http://www.edamam.com/ontologies/edamam.owl%23%0A%20%20%20%20%20%20
      recipe_364de010f901bb12a86698aa936adb8f"
    }

    before(:each) do
      stub_request(:get, 'https://api.edamam.com/search?')
      .with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'})
      .to_return(:status => 200, :body => "", :headers => {})
    end

    it 'shows a recipe if the recipe is found' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a 404 error if the recipe is not found' do
      #get :show, params: { id: 'Blue' }
      expect(response).to have_http_status(:not_found)
    end
  end
end
