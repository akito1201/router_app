class RemoveTransportationFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :transportation_id, :string
  end
end
