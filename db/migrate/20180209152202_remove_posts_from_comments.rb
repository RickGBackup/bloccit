class RemovePostsFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :post_id, :integer
  end
end
