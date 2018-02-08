class Labeling < ActiveRecord::Base
  belongs_to :labelable, polymorphic: true #stipulate that a labeling object is polymorphic and 
  #that it can mutate into different types of objects through labelable.  i.e. it can belong to a Topic, or belong to a Post.
  belongs_to :label
end