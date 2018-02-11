module LabelsHelper
  def labels_to_buttons(labels) 
    # Called in the labels/_list partial, and argument will be either @topic.labels or @post.labels.
    # Display the labels as buttons with links to their respective show views.
    raw labels.map { |l| link_to l.name, label_path(id: l.id), class: 'btn-xs btn-primary' }.join(' ')
  end
end
