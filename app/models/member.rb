class Member < ActiveHash::Base
    self.data = [
      { id: 1, name: '--' },
      { id: 2, name: '友達と' },
      { id: 3, name: 'デートで' },
      { id: 4, name: '家族で' },
      { id: 5, name: '一人で' }
    ]
  
  include ActiveHash::Associations
  has_many :posts
end
