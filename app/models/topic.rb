class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :sponsored_posts, dependent: :destroy
  
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings
  
  has_many :comments, as: :commentable
  
  validates :name, presence: true, length: {minimum: 5}
  validates :description, presence: true, length: {minimum: 15}
end
