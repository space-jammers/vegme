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

  let(:user_dislikes_all_recipes) do
    uri = 'http://www.edamam.com/ontologies/edamam.owl#recipe_23086a94b64c2ba96e12b0dde8b23eb4'
    user.recipes.create(user_id: user.id,
                        name: 'Pizza Frizza',
                        edamam_id: uri,
                        dislike: true)
    user.recipes.create(user_id: user.id,
                        name: 'Pizza Bianca',
                        edamam_id: uri,
                        dislike: true)
    user.recipes.create(user_id: user.id,
                        name: 'Cook the Book: Pizza Patate',
                        edamam_id: uri,
                        dislike: true)
  end

  let(:list_of_disliked) do
    QueryResult.disliked_in_results(user.disliked_recipes, QueryResult.hits)
  end

  let!(:store_query) do
    QueryResult.store_query_result(data_hash,
                                   'pizza',
                                   3)
  end

  describe 'return_query_term' do
    it 'returns stored query_term' do
      expect(QueryResult.return_query_term).to eq('pizza')
    end
  end

  describe 'return_limit' do
    it 'returns stored limit' do
      expect(QueryResult.return_limit).to eq(3)
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

  describe 'api_limit?' do
    it 'returns true if there is a limit error' do
      QueryResult.store_query_result(401, nil)
      expect(QueryResult.api_limit?).to eq(true)
    end

    it 'returns false if there is not a limit error' do
      expect(QueryResult.api_limit?).to eq(false)
    end
  end

  describe 'no_recipe_found?' do
    it 'returns true if no recipe is found' do
      QueryResult.store_query_result({ 'count' => 0 }, 'asdf')
      expect(QueryResult.no_recipe_found?).to eq(true)
    end

    it 'returns false if a recipe is found' do
      expect(QueryResult.no_recipe_found?).to eq(false)
    end
  end

  describe 'hits' do
    it 'returns the hits from the httparty response object' do
      expect(QueryResult.hits).to eq(data_hash['hits'])
    end
  end

  describe 'num_of_hits' do
    it 'returns the number of hits in results' do
      expect(QueryResult.num_of_hits).to eq(data_hash['to'])
    end
  end

  describe 'list_of_disliked' do
    it 'returns disliked recipes of current query' do
      user_dislike_recipe
      QueryResult.disliked_in_results(user.disliked_recipes, QueryResult.hits).length
      expect(list_of_disliked.length).to eq(1)
    end
  end

  describe 'filter_hits' do
    it 'returns filtered results' do
      user_dislike_recipe
      filtered = QueryResult.filter_hits(user.disliked_recipes, QueryResult.hits).length
      expect(filtered).to eq(2)
    end
  end

  describe 'compare_hits' do
    it 'returns list_of_disliked.length when hit count is greater than disliked count' do
      user_dislike_recipe
      compare = QueryResult.compare_hits(QueryResult.num_of_hits, list_of_disliked)
      expect(compare).to eq(list_of_disliked.length)
    end

    it 'returns num_of_hits when hit count is equal disliked count' do
      user_dislikes_all_recipes
      compare = QueryResult.compare_hits(QueryResult.num_of_hits, list_of_disliked)
      expect(compare).to eq(QueryResult.num_of_hits)
    end
  end
end
