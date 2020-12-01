class FavoriteCountsController < ApplicationController
  before_action :authenticate_user!
def index
  @favorite_counts = FavoriteCount.all.order("count DESC").includes(:post)
  @posts = Post.all.order("created_at DESC")
end

  def count
    favorite_count = FavoriteCount.find_by(post_id: params[:post_id])
      if favorite_count.present?
        favorite_count.update(post_id: params[:post_id], count: params[:count])
      else
        FavoriteCount.create(post_id: params[:post_id], count: params[:count])
      end
  end
end
