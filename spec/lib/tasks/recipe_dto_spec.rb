require 'rails_helper'
require 'tasks/recipe_dto'
file = File.read('spec/spicy_eggplant.json')
data_hash = JSON.parse(file)[0]

RSpec.describe RecipeDto do
  subject(:eggplant_dto) { RecipeDto.new(data_hash) }

  describe 'RecipeDto instantiation' do
    it 'creates an object with the recipe calories' do
      expect(eggplant_dto.calories).to eq(599.7433337402344)
    end

    it 'creates an object with the recipe image' do
      expect(eggplant_dto.image).to eq(
        'https://www.edamam.com/web-img/e39/e39d94b34518254159ee064a57cf5e22.jpg'
      )
    end

    it 'creates an object with the recipe ingredients' do
      expect(eggplant_dto.ingredient_list).to eq(
        [
          '7 cayenne peppers',
          '5 thai peppers',
          '4 shallots',
          '3 garlic cloves',
          '1 eggplant',
          'A pinches salt'
        ]
      )
    end

    it 'creates an object with the recipe name' do
      expect(eggplant_dto.label).to eq('Spicy Eggplant')
    end

    it 'creates an object with the recipe uri' do
      expect(eggplant_dto.uri).to eq(
        'http://www.edamam.com/ontologies/edamam.owl#recipe_a53ef6c8495adcb9f2859b1e5d99e9ba'
      )
    end

    it 'creates an object with the recipe url' do
      expect(eggplant_dto.url).to eq(
        'https://food52.com/recipes/15099-spicy-eggplant'
      )
    end

    it 'creates an object with the recipe yield' do
      expect(eggplant_dto.yield).to eq(2)
    end
  end
end
