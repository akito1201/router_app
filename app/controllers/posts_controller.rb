class PostsController < ApplicationController
  def index
    @posts = Post.all.order("created_at DESC")
  end

  def new
    @post_plan = PostPlan.new
  end

  def create
    @post_plan = PostPlan.new(post_plan_params)
    if @post_plan.valid?
      @post_plan.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
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

  def post_plan_params
    params.require(:post_plan).permit(:title, :outline, :prefecture_id, :city, :transportation_id, :member_id, :timing_id, :text, :place, :image).merge(user_id: current_user.id)
  end

  def post_plan_update_params
    params.require(:post_plan).permit(:title, :outline, :prefecture_id, :city, :transportation_id, :member_id, :timing_id, :text, :place, :image).merge(user_id: current_user.id, post_id: params[:id])
  end

end
