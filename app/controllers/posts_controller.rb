class PostsController < ApplicationController
  def index
    
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

  private

  def post_plan_params
    params.require(:post_plan).permit(:title, :outline, :prefecture_id, :city, :transportation_id, :member_id, :timing_id, :text, :place, :image).merge(user_id: current_user.id)
  end
end
