class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :member
  has_many :favorite_counts
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :plans, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :outline
  end

  with_options presence: true, numericality: { other_than: 1} do
    validates :prefecture_id
    validates :member_id

end



