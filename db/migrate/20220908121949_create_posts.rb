class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.text :info_link
      t.string :published_date
      t.string :image_link
      t.string :systemid
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
