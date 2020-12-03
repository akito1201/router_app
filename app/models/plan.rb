class Plan < ApplicationRecord
  has_one_attached :image
  belongs_to :post

  with_options presence: true do
    validates :text
    validates :place
  end
end
