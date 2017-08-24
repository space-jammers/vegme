class CreateFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :feedbacks do |t|
      t.string :label
      t.text :message, limit: 255
      t.string :link
      t.boolean :complete, default: false, null: false
      t.integer :admin_id
      t.integer :user_id
      t.timestamps
    end
    add_index :feedbacks, :user_id
  end
end
