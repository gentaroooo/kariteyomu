class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :info_link
      t.string :published_date
      t.string :image_link
      t.string :systemid
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
