class CreatePostAges < ActiveRecord::Migration[6.1]
  def change
    create_table :post_ages do |t|
      t.references :post, null: false, foreign_key: true
      t.references :age, null: false, foreign_key: true

      t.timestamps
    end
    add_index :post_ages, %i(age_id post_id), unique: true
  end
end
