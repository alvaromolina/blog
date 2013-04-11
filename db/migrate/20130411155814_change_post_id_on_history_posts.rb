class ChangePostIdOnHistoryPosts < ActiveRecord::Migration
	def change
    rename_column :history_posts, :posts_id, :post_id
  end
end
