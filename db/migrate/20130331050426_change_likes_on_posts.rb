class ChangeLikesOnPosts < ActiveRecord::Migration
  def up
  	change_column :posts, :likes, :integer, {:default => 0}
  end

  def down
  	change_column :posts, :likes, :integer
  end
end
