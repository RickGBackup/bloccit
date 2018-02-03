class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy   #delete all of a post's comments when that post is deleted
  
  default_scope  { order('created_at DESC') }  #Instruct rails to retrieve posts from the database by their created_at value, in descending order.
  scope :ordered_by_title, -> { order('title DESC') }
  scope :ordered_by_reverse_created_at, -> { order('created_at ASC') }
  
  #Scopes allow you to name and chain together SQL commands to select specific objects in a specific order.
  #Defining scopes in the model gives us new method calls for making DB queries.
  
  
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
  
  
  def censor_spam
    #censor the title of the first post, and every fifth post thereafter
    if self.id == 1 || (self.id - 1) % 5 == 0
      self.title = "SPAM"
    end
  end
end
