class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :search]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.valid?
      @post.save
      redirect_to controller: :plans, action: :new, post_id: @post.id
    else
      render :new
    end
  end

  def show
    @plans = Plan.where(post_id: @post.id)
    favorite = Favorite.find_by(user_id: current_user.id, post_id: @post.id)
    @favorite = favorite.checked? if favorite.present?
  end

  def edit
  end

  def update
    if @post.valid?
      @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def search
    keyword = params[:keyword]
    redirect_to root_path if keyword.nil?
    prefecture = Prefecture.find_by(name: params[:pref])
    if prefecture.present?
      posts = Post.where(prefecture_id: prefecture.id)
      title = posts.search(params[:keyword], 1)
      city = posts.search(params[:keyword], 2)
      outline = posts.search(params[:keyword], 3)
      @posts = title + city + outline
    elsif prefecture.nil?
      title = Post.search(params[:keyword], 1)
      city = Post.search(params[:keyword], 2)
      outline = Post.search(params[:keyword], 3)
      @posts = title + city + outline
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :outline, :prefecture_id, :city, :member_id).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
