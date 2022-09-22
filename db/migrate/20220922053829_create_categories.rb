class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :Categories, :name, unique: true
  end
end
