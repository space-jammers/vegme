module StaticPagesHelper
  def get_recipe_names(recipes)
    recipe_names = []
    recipes['hits'].each do |hit|
      recipe_names.push(hit['recipe']['label'])
    end

    recipe_names
  end
end
