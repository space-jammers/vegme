class RecipeData
  attr_accessor :json_recipe_list

  def initialize(json_recipe_list)
    @json_recipe_list = json_recipe_list
  end

  def each_recipe(key)
    recipes = {}
    @json_recipe_list['hits'].each do |hit|
      recipes[hit['recipe']['label']] = hit['recipe'][key]
    end

    recipes
  end
end
