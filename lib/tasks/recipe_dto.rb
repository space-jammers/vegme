class RecipeDto
  attr_accessor :calories, :image, :ingredient_list, :label, :uri, :url, :yield

  def initialize(json_object)
    self.calories = json_object[0]['calories']
    self.image = json_object[0]['image']
    self.ingredient_list = json_object[0]['ingredientLines']
    self.label = json_object[0]['label']
    self.uri = json_object[0]['uri']
    self.url = json_object[0]['url']
    self.yield = json_object[0]['yield']
  end
end
