class PlansController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @plan = Plan.new
  end

  def create
    plan = Plan.create(plan_params)
    if plan.valid?
      plan.save
    else
      render :new
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:text, :place).merge(post_id: params[:post_id])
  end

end
