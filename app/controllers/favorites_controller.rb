class FavoritesController < ApplicationController
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
    render json: { post: post }
  end

  def index
    @favorites = Favorite.where(user_id: current_user.id, checked: true).includes(:post)
  end
end
