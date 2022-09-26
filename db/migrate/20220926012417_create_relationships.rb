class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :followed, null: false, foreign_key: { to_table: :users }
      t.references :follower, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :relationships, [:followed_id, :follower_id], unique: true
  end
end