class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  after_create :send_favorite_emails

  validates :body, length: {minimum: 5 }, presence: true
  validates :user, presence: true
  
  private
  def send_favorite_emails
    # called after a comment is created.
    #create and send an email to every user that has favorited the post that was commented on.
    if commentable_type == "Post"
      post = commentable
      post.favorites.each do |favorite|
        FavoriteMailer.new_comment(favorite.user, post, self).deliver_now
      end
    end
  end
end
