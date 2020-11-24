class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.text :text, null: false
      t.string :place, null: false
      t.references :post, foreign_key: true
      t.timestamps
    end
  end
end
