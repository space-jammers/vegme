class RecipeDto
  attr_accessor :calories, :e_id, :image, :ingredient_list, :label, :url, :yield

  def initialize(json_object)
    self.calories = get_default(json_object, 'calories')
    self.image = get_default(json_object, 'image')
    self.ingredient_list = get_default(json_object, 'ingredientLines')
    self.label = get_default(json_object, 'label')
    self.e_id = get_default(json_object, 'uri')
                .match(/_[[:alnum:]]*(\Z || \&)/).to_s[1..-1]
    self.url = get_default(json_object, 'url')
    self.yield = get_default(json_object, 'yield')
  end

  def get_default(obj, key, default = nil)
    obj.include?(key) ? obj[key] : default
  end

  # --NOT YET WORKING -- This method can be used to do get_default
  # for nested JSON
  # def default_value(jo, keys, default = nil)
  #   d = jo
  #   keys[0...-1].each do |key|
  #     puts key.inspect
  #     return default unless d.include?(key)
  #     d = d[key]
  #   end
  #   return default unless d.include?(keys.last)
  #   keys[-1]
  # end
end
