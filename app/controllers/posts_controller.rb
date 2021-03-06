class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :new_guest]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :search, :new_guest]

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
    pref = params[:pref]
    keyword = params[:keyword]
    redirect_to root_path if keyword == '' && pref == '--都道府県を選択--'
    prefecture = Prefecture.find_by(name: params[:pref])
    # 都道府県を選択している場合
    if pref != '--都道府県を選択--'
      # Postのカラム検索
      posts = Post.where(prefecture_id: prefecture.id)
      title = posts.search(params[:keyword], 1)
      city = posts.search(params[:keyword], 2)
      outline = posts.search(params[:keyword], 3)
      @posts = title + city + outline - (title && city && outline) + (title && city && outline)

      # # Planのカラム検索
      # place = Plan.search(params[:keyword], 1)
      # places = posts.where(id: place[0].post_id..place[place.length - 1].post_id) if place.present?
      # content = Plan.search(params[:keyword], 2)
      # contents = posts.where(id: content[0].post_id..content[content.length - 1].post_id) if content.present?
      # if place.present? && content.present?
      #   @posts += contents + places - (contents && places) + (contents && places)
      # elsif place.present?
      #   @posts += places
      # elsif content.present?
      #   @posts += contents
      # end

      # 都道府県を選択していない場合
    elsif pref == '--都道府県を選択--'
      # Postのカラム検索
      title = Post.search(keyword, 1)
      city = Post.search(keyword, 2)
      outline = Post.search(keyword, 3)
      @posts = title + city + outline - (title && city && outline) + (title && city && outline)

      # # Planのカラム検索
      # place = Plan.search(params[:keyword], 1)
      # places = Post.where(id: place[0].post_id..place[place.length - 1].post_id) if place.present?
      # content = Plan.search(params[:keyword], 2)
      # contents = Post.where(id: content[0].post_id..content[content.length - 1].post_id) if content.present?
      # if place.present? && content.present?
      #   @posts += contents + places - (contents && places) + (contents && places)
      # elsif place.present?
      #   @posts += places
      # elsif content.present?
      #   @posts += contents
      # end

    end
  end

  def new_guest
    user = User.find_or_create_by!(email: 'guest@com', nickname: 'guest') do |user|
      user.password = 'aaa111'
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
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
