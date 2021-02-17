class Plan < ApplicationRecord
  has_rich_text :content
  belongs_to :post

  with_options presence: true do
    validates :place
    validates :content
  end

  def self.search(search, num)
    if search != ''
      if num == 1
        Plan.where('place LIKE(?)', "%#{search}%")
      elsif num == 2
        Plan.where('text LIKE(?)', "%#{search}%")
      end
    end
  end
end
