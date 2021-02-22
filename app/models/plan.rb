class Plan < ApplicationRecord
  has_rich_text :content
  belongs_to :post

  with_options presence: true do
    validates :place
    validates :content
  end

  def self.search(search, num)
    if search != ''
      case num
      when 1
        Plan.where('place LIKE(?)', "%#{search}%")
      when 2
        Plan.where('text LIKE(?)', "%#{search}%")
      end
    end
  end
end
