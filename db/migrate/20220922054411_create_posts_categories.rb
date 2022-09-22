class CreatePostsCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :posts_categories do |t|
      t.references :post, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :posts_categories, %i(category_id post_id), unique: true
  end
end
