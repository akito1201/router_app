class PostPlan
  include ActiveModel::Model
  attr_accessor :title, :outline, :prefecture_id, :city, :member_id, :transportation_id, :timing_id, :text, :image, :place, :post_id, :user_id

  with_options presence: true do
    validates :title
    validates :outline
  end

  with_options presence: true, numericality: { other_than: 1} do
    validates :prefecture_id
    validates :transportation_id
    validates :member_id
    validates :timing_id
  end

  def save
    post = Post.create(title: title, outline: outline, prefecture_id: prefecture_id, city: city, transportation_id: transportation_id, member_id: member_id, timing_id: timing_id, user_id: user_id)
    Plan.create(text: text, place: place, image: image, post_id: post.id)
    @post_name = post.id
  end

  def update
    post = Post.find_by(id: post_id)
    post.update(title: title, outline: outline, prefecture_id: prefecture_id, city: city, transportation_id: transportation_id, member_id: member_id, timing_id: timing_id)
    Plan.find_by(post_id: post.id).update(text: text, place: place, image: image)
  end
end
