class PostsController < ApplicationController
  def index
    
  end

  def new
    @post_plan = PostPlan.new
  end
end
