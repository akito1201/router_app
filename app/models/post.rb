class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :transportation
  belongs_to :member
  belongs_to :timing
  has_many :favorite_counts
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :plans, dependent: :destroy
end



