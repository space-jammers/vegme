module RecipesHelper
  def percent_cals_from_fat(recipe)
    ((recipe.fat * 9) / recipe.calories) * 100
  end

  def percent_cals_from_protein(recipe)
    ((recipe.protein * 4) / recipe.calories) * 100
  end

  def percent_cals_from_carbs(recipe)
    ((recipe.carbs * 4) / recipe.calories) * 100
  end
end
