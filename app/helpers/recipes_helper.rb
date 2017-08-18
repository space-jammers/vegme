module RecipesHelper
  def percent_cals_from_fat(recipe)
    (((recipe.fat * 9) / recipe.calories) * 100).round(1)
  end

  def percent_cals_from_protein(recipe)
    (((recipe.protein * 4) / recipe.calories) * 100).round(1)
  end

  def percent_cals_from_carbs(recipe)
    (((recipe.carbs * 4) / recipe.calories) * 100).round(1)
  end

  def total_percent_cals(recipe)
    (percent_cals_from_fat(recipe) +
    percent_cals_from_protein(recipe) +
    percent_cals_from_carbs(recipe)).round(1)
  end

  def fat_cal_percent_adjusted(recipe)
    ((percent_cals_from_fat(recipe) /
    total_percent_cals(recipe)) * 100).round(1)
  end

  def protein_cal_percent_adjusted(recipe)
    ((percent_cals_from_protein(recipe) /
    total_percent_cals(recipe)) * 100).round(1)
  end

  def carbs_cal_percent_adjusted(recipe)
    ((percent_cals_from_carbs(recipe) /
    total_percent_cals(recipe)) * 100).round(1)
  end
end
