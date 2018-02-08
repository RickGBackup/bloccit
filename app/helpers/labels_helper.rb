module LabelsHelper
  def labels_to_buttons(labels) 
    # Called in the _list partial, and argument will be either @topic.labels or @post.labels.
    # Create labels as buttons with links to respective show views.
    raw labels.map { |l| link_to l.name, label_path(id: l.id), class: 'btn-xs btn-primary' }.join(' ')
  end
end
