require 'rails_helper'
file = File.read('spec/three_pizza_query.json')
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
      query = QueryResult.new(data_hash, '1234')
      query.hits[0]
    end

    it 'creates a RecipeDto object from the recipe json data' do
      expect(recipe.make_dto.class).to eq(RecipeDto.new(recipe['recipe']).class)
    end

    it 'creates a RecipeDto object that has the correct values (testing label)' do
      expect(recipe.make_dto.label).to eq(RecipeDto.new(recipe['recipe']).label)
    end
  end

  describe 'create_search_id' do
    it 'creates identifiers that are unique' do
      uid1 = create_search_id
      uid2 = create_search_id
      expect(uid1).to_not eq(uid2)
    end
  end
end
