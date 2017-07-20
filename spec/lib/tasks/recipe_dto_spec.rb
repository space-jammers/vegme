require 'rails_helper'
require 'tasks/recipe_dto'
file = File.read('spec/spicy_eggplant.json')
data_hash = JSON.parse(file)[0]

RSpec.describe RecipeDto do
  subject(:eggplant_dto) { RecipeDto.new(data_hash) }

  describe 'RecipeDto instantiation' do
    it 'creates an object with the recipe calories' do
      expect(eggplant_dto.calories).to eq(data_hash['calories'])
    end

    it 'creates an object with the recipe image' do
      expect(eggplant_dto.image).to eq(data_hash['image'])
    end

    it 'creates an object with the recipe ingredients' do
      expect(eggplant_dto.ingredient_list).to eq(data_hash['ingredientLines'])
    end

    it 'creates an object with the recipe name' do
      expect(eggplant_dto.label).to eq(data_hash['label'])
    end

    it 'creates an object with the recipe id' do
      expect(eggplant_dto.e_id).to eq(data_hash['uri']
      .match(/_[[:alnum:]]*(\Z || \&)/).to_s[1..-1])
    end

    it 'creates an object with the recipe url' do
      expect(eggplant_dto.url).to eq(data_hash['url'])
    end

    it 'creates an object with the recipe yield' do
      expect(eggplant_dto.yield).to eq(data_hash['yield'])
    end
  end
end
