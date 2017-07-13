class RecipeDto
  attr_accessor :calories, :image, :ingredient_list, :label, :uri, :url, :yield

  def initialize(json_object)
    self.calories = json_object['calories']
    self.image = json_object['image']
    self.ingredient_list = json_object['ingredientLines']
    self.label = json_object['label']
    self.uri = json_object['uri']
    self.url = json_object['url']
    self.yield = json_object['yield']
  end
end
