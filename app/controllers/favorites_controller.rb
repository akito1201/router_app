class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def check
    favorite = Favorite.find_by(post_id: params[:post_id], user_id: current_user.id)
    if favorite.present?
      if favorite.checked?
        favorite.update(checked: false)
      else
        favorite.update(checked: true)
      end
    else
      Favorite.create(user_id: current_user.id, post_id: params[:post_id], checked: true)
    end
    post = Favorite.find_by(post_id: params[:post_id], user_id: current_user.id)
    count = Favorite.where(post_id: params[:post_id], checked: true).length
    render json: { post: post, count: count }
  end

  def index
    @favorites = Favorite.where(user_id: current_user.id, checked: true).includes(:post)
  end
end
