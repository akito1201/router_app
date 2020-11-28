class PlansController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @plans = Plan.where(post_id: @post.id)
    @plan = Plan.new
  end

  def create
    plan = Plan.create(plan_params)
    if plan.valid?
      plan.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @plan = Plan.find_by(id: params[:id], post_id: params[:post_id])
  end

  def update
    plan = Plan.find(params[:id])
    if plan.update
      redirect_to "posts#show"
    else
      render :edit
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:text, :place, :image).merge(post_id: params[:post_id])
  end

end
