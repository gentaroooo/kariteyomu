class CreateUserLibraries < ActiveRecord::Migration[6.1]
  def change
    create_table :user_libraries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ribrary, null: false, foreign_key: true

      t.timestamps
    end
    add_index :user_libraries, %i(user_id library_id), unique: true
  end
end
