class Transportation < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '車' },
    { id: 3, name: '電車' },
    { id: 4, name: '車 or 電車' }
  ]

  include ActiveHash::Associations
  has_many :posts
  
  end