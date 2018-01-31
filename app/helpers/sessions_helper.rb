module SessionsHelper
  
  
  def create_session(user)
    session[:user_id] = user.id  
    #session is an object rails provides to track the state of a user
    #1-to-1 relship between sessions and users.
    #session can only have 1 user ID, & a user only related to 1 session.
  end
  
  def destroy_session(user)
    session[:user_id] = nil
  end
  
  def current_user  #this can 
    User.find_by(id: session[:user_id])
  end
end
