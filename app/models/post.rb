class Post < ActiveRecord::Base
  has_many :comments
  
  def censor_spam
    #censor the title of the first post, and every fifth post thereafter
    if self.id == 1 || (self.id - 1) % 5 == 0
      self.title = "SPAM"
    end
  end
end
