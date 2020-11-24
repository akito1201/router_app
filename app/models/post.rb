class Post < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :transportation
  belongs_to :member
  belongs_to :time

  with_options presence: true do
    validates :title
    validates :outline
  end

  with_options presence: true, numericality: { other_than: 1} do
    validates :prefecture_id
    validates :transportation_id
    validates :member_id
    validates :time_id
  end

end



