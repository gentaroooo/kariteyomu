class CreatePostAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :post_authors do |t|
      t.references :post, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end

    add_index :post_authors, [:post_id, :author_id], unique: true
  end
end
