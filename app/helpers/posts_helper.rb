module PostsHelper
  def user_authorized_to_edit_post?(post, user)
    #true if there's a logged in user, and they either own the post, or are an admin
    user == post.user || user.admin? || user.moderator? 
  end
  
  def user_authorized_to_delete_post?(post, user)
    #user can delete if signed in, not a moderator, and owns the post or is an admin.
    user == post.user || user.admin?
  end
end
