class UpdateDislikeColumnInRecipes < ActiveRecord::Migration[5.0]
  def change
    change_column :recipes, :dislike, :boolean, null: false, default: false
  end
end
