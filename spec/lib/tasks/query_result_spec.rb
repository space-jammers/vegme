require 'rails_helper'
require 'tasks/query_result'
file = File.read('spec/three_pizza_query.json')
data_hash = JSON.parse(file)

RSpec.describe 'QueryResult' do
  let(:user) { User.create!(email: 'test2@here.com', password: 'sdkjh59sda') }

  let(:user_dislike_recipe) do
    uri = 'http://www.edamam.com/ontologies/edamam.owl#recipe_23086a94b64c2ba96e12b0dde8b23eb4'
    user.recipes.create(user_id: user.id,
                        name: 'Pizza Frizza',
                        edamam_id: uri,
                        dislike: true)
  end

  let(:store_query) do
    QueryResult.new(data_hash,
                    '1234')
  end

  describe 'query_error?' do
    it 'returns true if there is an error' do
      error = QueryResult.new(403, nil)
      expect(error.query_error?).to eq(true)
    end

    it 'returns false if there is not an error' do
      expect(store_query.query_error?).to eq(false)
    end
  end

  describe 'api_limit?' do
    it 'returns true if there is a limit error' do
      error = QueryResult.new(401)
      expect(error.api_limit?).to eq(true)
    end

    it 'returns false if there is not a limit error' do
      expect(store_query.api_limit?).to eq(false)
    end
  end

  describe 'no_recipe_found?' do
    it 'returns true if no recipe is found' do
      error = QueryResult.new('count' => 0)
      expect(error.no_recipe_found?).to eq(true)
    end

    it 'returns false if a recipe is found' do
      expect(store_query.no_recipe_found?).to eq(false)
    end
  end

  describe 'hits' do
    it 'returns the hits from the httparty response object' do
      expect(store_query.hits).to eq(data_hash['hits'])
    end
  end

  describe 'num_of_hits' do
    it 'returns the number of hits in results' do
      expect(store_query.num_of_hits).to eq(data_hash['to'])
    end
  end

  describe 'filter_hits' do
    it 'returns filtered results' do
      user_dislike_recipe
      filtered = store_query.filter_hits(user.disliked_recipes, store_query.hits).length
      expect(filtered).to eq(2)
    end
  end
end
