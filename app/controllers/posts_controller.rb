class PostsController < ApplicationController
  def index
    @posts = Post.all.order("created_at DESC")
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
    @post = Post.find(params[:id])
    @plan = Plan.where(post_id: @post.id)
  end

  def edit
    @post = Post.find(params[:id])
    @plan = Plan.find_by(post_id: @post.id)
    @post_plan = PostPlan.new(post_id: params[:id])
  end

  def update
    @post_plan = PostPlan.new(post_plan_update_params)
    if @post_plan.update
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :outline, :prefecture_id, :city, :transportation_id, :member_id, :timing_id).merge(user_id: current_user.id)
  end



end
