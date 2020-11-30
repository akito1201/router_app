class FavoriteCountsController < ApplicationController
  def count
    favorite_count = FavoriteCount.find_by(post_id: params[:post_id])
      if favorite_count.present?
        favorite_count.update(post_id: params[:post_id], count: params[:count])
      else
        FavoriteCount.create(post_id: params[:post_id], count: params[:count])
      end
  end
end
