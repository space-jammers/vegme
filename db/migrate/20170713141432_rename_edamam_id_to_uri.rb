class RenameEdamamIdToUri < ActiveRecord::Migration[5.0]
  def change
    rename_column :recipes, :edamam_id, :edamam_uri
  end
end
