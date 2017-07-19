require 'rails_helper'
require 'tasks/query_result'
# require 'json'
file = File.read('spec/data.json')
data_hash = JSON.parse(file)

RSpec.describe 'QueryResult' do
  before(:each) do
    QueryResult.store_query_result(data_hash, 'pizza')
  end

  describe 'return_query_term' do
    it 'returns stored query_term' do
      expect(QueryResult.return_query_term).to eq('pizza')
    end
  end

  describe 'query_error?' do
    it 'returns true if there is an error' do
      QueryResult.store_query_result(403, nil)
      expect(QueryResult.query_error?).to eq(true)
    end

    it 'returns false if there is not an error' do
      expect(QueryResult.query_error?).to eq(false)
    end
  end

  describe 'no_recipe_found?' do
    it 'returns true if no recipe is found' do
      QueryResult.store_query_result({ 'count' => 0 }, 'asdf')
      expect(QueryResult.no_recipe_found?).to eq(true)
    end

    it 'returns falise if a recipe is found' do
      expect(QueryResult.no_recipe_found?).to eq(false)
    end
  end

  describe 'hits' do
    it 'returns the hits from the httparty response object' do
      expect(QueryResult.hits).to eq(data_hash['hits'])
    end
  end
end
