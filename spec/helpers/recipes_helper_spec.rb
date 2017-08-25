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

  describe 'total_percent_cals' do
    it 'calculates the sum of percents from the three "percent" methods' do
      fat_percent = percent_cals_from_fat(eggplant_dto)
      protein_percent = percent_cals_from_protein(eggplant_dto)
      carbs_percent = percent_cals_from_carbs(eggplant_dto)
      expect(total_percent_cals(eggplant_dto)).to eq(fat_percent + protein_percent + carbs_percent)
    end
  end

  describe 'fat_cal_percent_adjusted' do
    it 'finds proportional fat cal percentage relative to total percent cals' do
      adjusted_fat = ((percent_cals_from_fat(eggplant_dto) /
        total_percent_cals(eggplant_dto)) * 100).round(1)
      expect(fat_cal_percent_adjusted(eggplant_dto)).to eq(adjusted_fat)
    end
  end

  describe 'protein_cal_percent_adjusted' do
    it 'finds proportional protein cal percentage relative to total percent cals' do
      adjusted_protein = ((percent_cals_from_protein(eggplant_dto) /
        total_percent_cals(eggplant_dto)) * 100).round(1)
      expect(protein_cal_percent_adjusted(eggplant_dto)).to eq(adjusted_protein)
    end
  end

  describe 'carbs_cal_percent_adjusted' do
    it 'finds proportional carbs cal percentage relative to total percent cals' do
      adjusted_carbs = ((percent_cals_from_carbs(eggplant_dto) /
        total_percent_cals(eggplant_dto)) * 100).round(1)
      expect(carbs_cal_percent_adjusted(eggplant_dto)).to eq(adjusted_carbs)
    end
  end
end
