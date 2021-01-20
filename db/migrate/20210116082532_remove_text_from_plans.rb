class RemoveTextFromPlans < ActiveRecord::Migration[6.0]
  def change
    remove_column :plans, :text, :string
  end
end
