class RemoveBoFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :bo, :text
  end
end
