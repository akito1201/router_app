class UsersController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(user_id: current_user.id)
  end
  
  def show
    @user = User.find_by(id: params[:user_id])
    @posts = Post.where(user_id: @user.id)
  end

end
