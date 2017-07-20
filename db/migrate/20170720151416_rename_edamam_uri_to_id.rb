class RenameEdamamUriToId < ActiveRecord::Migration[5.0]
  def change
    rename_column :recipes, :edamam_uri, :edamam_id
  end
end
