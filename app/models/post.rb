class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :member
  has_many :favorite_counts, dependent: :destroy

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :plans, dependent: :destroy
  

  with_options presence: true do
    validates :title
    validates :outline
  end

  with_options presence: true, numericality: { other_than: 1, message: 'を選択してください'}  do
    validates :prefecture_id
    validates :member_id
  end

  def self.search(search, num)
    if search != ''
      if num == 1
        Post.where('title LIKE(?)', "%#{search}%")
      elsif num == 2
        Post.where('city LIKE(?)', "%#{search}%")
      elsif num == 3
        Post.where('outline LIKE(?)', "%#{search}%")
      end
    else
      Post.all.order('created_at DESC')
    end
  end
end
