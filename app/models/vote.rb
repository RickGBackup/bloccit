class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  after_save :update_post  #after a vote is saved, update rank of it's associated post.
  
  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." }, presence: true

  private 
  
  def update_post
    post.update_rank
  end
end
