class CreateQueries < ActiveRecord::Migration[5.0]
  def change
    create_table :queries do |t|
      t.string :query_term
      t.integer :results_limit
      t.string :health
      t.timestamps
    end
  end
end
