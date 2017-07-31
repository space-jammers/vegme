require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'disliked_recipes' do
    let(:user) { User.create!(email: 'test@here.com', password: 'sdkjh59sda') }
    before do
      uri = 'http://www.edamam.com/ontologies/edamam.owl#recipe_a53ef6c8495adcb9f2859b1e5d99e9ba'
      user.recipes.create(user_id: user.id,
                          name: 'Spicy Eggplant',
                          edamam_id: uri,
                          dislike: true)
    end
    it 'returns a list of disliked recipes names' do
      expect(user.disliked_recipes).to match_array(['Spicy Eggplant'])
    end
  end
end
