class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy 
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  before_save { self.email = email.downcase if email.present? }  #the assigned email is downcased before the User is saved.
  before_save { self.name = name.split.map! { |name| name.capitalize }.join(" ") if name.present? }  #Convert name to camel case before User is saved.
  before_save { self.role ||= :member }  #Set the role to member if the the user has no role attribute
  
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  
  validates :password, presence: true, length: { minimum: 6 }, unless: :password_digest   #Ensures that when we create a new user, they have a pw
  validates :password, length: { minimum: 6 }, allow_blank: true  #Allows nothing to be passed for pw, if the 
  # user already exists. So we can update other attributes without having to set new pw.
  
  validates :email,
             presence: true,
             uniqueness: { case_sensitive: false },
             length: { minimum: 3, maximum: 254 }
  
  has_secure_password  #Adds methods for setting/authenticating pws, and hashing them, so they're saved
  #in an encrypted format.
  
  enum role: [:member, :admin, :moderator]  #allows us to reference/assign the role attribute, which is an integer using

  def favorite_for(post)
    favorites.where(post_id: post.id).first
  end
end