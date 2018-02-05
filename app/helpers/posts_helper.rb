module PostsHelper
  def user_authorized_to_edit_post?(post)
    #true if there's a logged in user, and they either own the post, or are an admin
    current_user && (current_user == post.user || current_user.admin? || current_user.moderator? )
  end
  
  def user_authorized_to_delete_post?(post)
    #user can delete if signed in, not a moderator, and owns the post or is an admin.
    current_user && !current_user.moderator? &&  (current_user == post.user || current_user.admin?)
  end
end
