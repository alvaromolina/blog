class RemoveLikesToPosts < ActiveRecord::Migration
  def up
  	remove_column :posts, :likes
  end

  def down
  	add_column	:posts, :likes, :integer
  end
end
