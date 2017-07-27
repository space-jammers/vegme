class AddColumnToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :dislike, :boolean, default: false
  end
end
