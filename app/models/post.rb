class Post < ActiveRecord::Base
  has_many :comments
  
  def censor_spam
    if self.id == 1 || (self.id - 1) % 5 == 0
      self.title = "SPAM"
    end
  end
end
