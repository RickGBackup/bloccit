class AddTopicToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :topic_id, :integer  #adds the topic ID as a foreign key in the posts table.
    add_index :posts, :topic_id  #indexing foreign keys speeds up DB operations.
  end
end
