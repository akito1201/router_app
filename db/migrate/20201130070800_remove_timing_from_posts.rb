class RemoveTimingFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :timing_id, :integer
  end
end
