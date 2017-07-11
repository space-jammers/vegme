require 'rails_helper'
require 'tasks/query_result'
require 'json'
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

  describe 'return_query_result' do
    it 'returns query result' do
      expect(QueryResult.return_query_result).to eq(data_hash)
    end
  end

  describe 'result_created?' do
    it 'returns true if result is created'
    it 'returns false if result is not created'
  end

  describe 'query_error?' do
    it 'returns true if there is an error'
    it 'returns false if there is not an error'
  end

  describe 'no_recipe_found?' do
    it 'returns true if no recipe is found'
    it 'returns falise if a recipe is found'
  end
end
