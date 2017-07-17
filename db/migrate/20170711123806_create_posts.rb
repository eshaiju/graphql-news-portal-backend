class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :author_id
      t.string :title
      t.string :url
      t.datetime :published_at
      t.integer :votes
      t.text :body

      t.timestamps
    end
  end
end
