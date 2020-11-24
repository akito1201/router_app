class PostPlan
  include ActiveModel::Model
  attr_accessor :title, :outline, :prefecture_id, :city, :member_id, :timing_id, :text, :image, :place, :post_id, :user_id

  def save
    post = Post.create(title: title, outline: outline, prefecture_id: prefecture_id, city: city, transportation_id: transportation_id, member_id: member_id, timing_id: timing_id, user_id: current_user.id)
    Plan.create(text: text, place: place, post_id: post.id)
  end
end
