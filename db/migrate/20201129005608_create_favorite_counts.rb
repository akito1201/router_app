class CreateFavoriteCounts < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_counts do |t|
      t.integer :count, null: false
      t.references :post, foreign_key: true
      t.timestamps
    end
  end
end
