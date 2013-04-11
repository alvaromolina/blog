class CreateHistoryPosts < ActiveRecord::Migration
  def change
    create_table :history_posts do |t|
      t.references :posts
      t.text :body

      t.timestamps
    end
    add_index :history_posts, :posts_id
  end
end
