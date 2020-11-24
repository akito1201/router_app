class Timing < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '午前中' },
    { id: 3, name: '午後' },
    { id: 4, name: '1日' },
  ]

include ActiveHash::Associations
has_many :posts
end
