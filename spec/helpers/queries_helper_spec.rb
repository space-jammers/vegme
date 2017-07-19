require 'rails_helper'
require 'tasks/query_result'
require 'tasks/recipe_dto'
file = File.read('spec/data.json')
data_hash = JSON.parse(file)

# Specs in this file have access to a helper object that includes
# the QueriesHelper. For example:
#
# describe QueriesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe QueriesHelper, type: :helper do
  describe 'make_dto' do
    subject(:recipe) do
      QueryResult.store_query_result(data_hash, 'pizza')
      QueryResult.hits[0]
    end

    it 'creates a RecipeDto object from the recipe json data' do
      expect(recipe.make_dto.class).to eq(RecipeDto.new(recipe['recipe']).class)
    end

    it 'creates a RecipeDto object that has the correct values (testing label)' do
      expect(recipe.make_dto.label).to eq(RecipeDto.new(recipe['recipe']).label)
    end
  end
end
