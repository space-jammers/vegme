class Addcolumntoqueries < ActiveRecord::Migration[5.0]
  def change
    add_column :queries, :payload, :json
  end
end
