require 'rails_helper'
require 'tasks/recipe_dto'
file = File.read('spec/spicy_eggplant.json')
data_hash = JSON.parse(file)[0]

# Specs in this file have access to a helper object that includes
# the RecipesHelper. For example:
#
# describe RecipesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe RecipesHelper, type: :helper do
  subject(:eggplant_dto) { RecipeDto.new(data_hash) }

  describe 'percent_cals_from_fat' do
    it 'gives the percentage of total calories from fat' do
      fat_percent = ((data_hash['totalNutrients']['FAT']['quantity'] * 9) /
        data_hash['calories']) * 100
      expect(RecipesHelper.percent_cals_from_fat(eggplant_dto))
        .to eq(fat_percent)
    end
  end

  describe 'percent_cals_from_protein' do
    it 'gives the percentage of total calories from protein' do
      protein_percent = ((data_hash['totalNutrients']['PROCNT']['quantity'] * 4) /
        data_hash['calories']) * 100
      expect(RecipesHelper.percent_cals_from_protein(eggplant_dto))
        .to eq(protein_percent)
    end
  end

  describe 'percent_cals_from_carbs' do
    it 'gives the percentage of total calories from carbs' do
      carbs_percent = ((data_hash['totalNutrients']['CHOCDF']['quantity'] * 4) /
        data_hash['calories']) * 100
      expect(RecipesHelper.percent_cals_from_carbs(eggplant_dto))
        .to eq(carbs_percent)
    end
  end
end
