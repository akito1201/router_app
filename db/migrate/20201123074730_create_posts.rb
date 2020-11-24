class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :outline, null: false
      t.integer :prefecture_id, null: false
      t.string :city, null: false
      t.integer :transportation_id, null: false
      t.integer :member_id, null: false
      t.integer :timing_id, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
