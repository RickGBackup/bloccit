class Post < ActiveRecord::Base
  belongs_to :topic
  has_many :comments, dependent: :destroy   #delete all of a post's comments when that post is deleted
  
  def censor_spam
    #censor the title of the first post, and every fifth post thereafter
    if self.id == 1 || (self.id - 1) % 5 == 0
      self.title = "SPAM"
    end
  end
end
