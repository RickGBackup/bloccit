module ApplicationHelper
  
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?
    content_tag :div, capture(&block), class: css_class
  end
end

# Explaining form_group_tag to myself:

# form_group_tag takes as arguments the errors array, and a Proc, which works like a reusuable code block.
# we will use form_group_tag in forms.
# It returns different HTML content depending on whether the errors array is empty or not.

# capture(&block) captures the return value of &block.

# content_tag return a block of HTML code.

# How form_group_tag is used:

#In posts/views/_forms.html.erb, we call:

# <%= form_group_tag(post.errors[:title]) do %>
  #1
#   <%= f.label :title %>
#   <%= f.text_field :title, class: 'form-control', placeholder: "Enter post title" %>

# <% end %>

# It returns a div containing the return value of the inner block #1,
# with the css-class set to 'form-group' on 'form-group has-error', depending 
# # whether there was an error.

# So, if there was an error, form_group_tag will style the form element accordingly - in this case,
# it makes makes the erroneous field red-bordered.

# We could then change the CSS class has-error, or create our own and include it in
# form_for_tag, if we wanted a different
# styling for erroneous fields.






