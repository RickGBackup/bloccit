class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :sponsored_posts, dependent: :destroy
  
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings
  
  has_many :comments, as: :commentable
  
  scope :visible_to, -> (user) { user ? all : where(public: true) }  # scope generates the method visible_to(user).
  #visible_to(user) runs the logic in the block on the relation/class it is called on.
  # It returns either Topic.all or Topic.where(pubic: true), dependent on truthiness of its argument, user.
  
  validates :name, presence: true, length: {minimum: 5}
  validates :description, presence: true, length: {minimum: 15}
end
