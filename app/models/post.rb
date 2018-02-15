class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy   #delete all of a post's comments when that post is deleted
  has_many :votes, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings
  has_many :favorites, dependent: :destroy
  after_create :create_vote, :create_favorite, :send_email_notification
  
  default_scope  { order('rank DESC') }  #Instruct rails to retrieve posts from the database by their rank value, in descending order.
  scope :ordered_by_title, -> { order('title DESC') }
  scope :ordered_by_reverse_created_at, -> { order('created_at ASC') }
  
  #Scopes allow you to name and chain together SQL commands to select specific objects in a specific order.
  #Defining scopes in the model gives us new method calls for making DB queries.
  
  
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
  
  def up_votes
    # where and sum are ActiveRecord methods
    votes.where(value: 1).count
  end
  
  def down_votes
    votes.where(value: -1).count
  end
  
  def points
    votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds   # age in days from Jan 1st 1970.  1.day.seconds is made possible by active_support module
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end
    
  def censor_spam
    #censor the title of the first post, and every fifth post thereafter
    if self.id == 1 || (self.id - 1) % 5 == 0
      self.title = "SPAM"
    end
  end
  
  private
  
  def create_vote
    user.votes.create(value: 1, post: self)
  end
  
  def create_favorite
    user.favorites.create( post: self)
  end
  
  def send_email_notification
    FavoriteMailer.new_post(favorite.user, self).deliver_now
  end
end
