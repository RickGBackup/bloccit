module PostsHelper
  def user_is_authorized_for_post?(post)
    #true if there's a logged in user, and they either own the post, or are an admin
    current_user && (current_user == post.user || current_user.admin?)
  end
end
