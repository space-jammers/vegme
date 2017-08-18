require 'rails_helper'
file = File.read('spec/spicy_eggplant.json')
data_hash = JSON.parse(file)[0]

RSpec.describe RecipesHelper, type: :helper do
  subject(:eggplant_dto) { RecipeDto.new(data_hash) }

  describe 'percent_cals_from_fat' do
    it 'gives the percentage of total calories from fat' do
      fat_percent = ((data_hash['totalNutrients']['FAT']['quantity'] * 9) /
        data_hash['calories']) * 100
      expect(percent_cals_from_fat(eggplant_dto))
        .to eq(fat_percent.round(1))
    end
  end

  describe 'percent_cals_from_protein' do
    it 'gives the percentage of total calories from protein' do
      protein_percent = ((data_hash['totalNutrients']['PROCNT']['quantity'] * 4) /
        data_hash['calories']) * 100
      expect(percent_cals_from_protein(eggplant_dto))
        .to eq(protein_percent.round(1))
    end
  end

  describe 'percent_cals_from_carbs' do
    it 'gives the percentage of total calories from carbs' do
      carbs_percent = ((data_hash['totalNutrients']['CHOCDF']['quantity'] * 4) /
        data_hash['calories']) * 100
      expect(percent_cals_from_carbs(eggplant_dto))
        .to eq(carbs_percent.round(1))
    end
  end
end
