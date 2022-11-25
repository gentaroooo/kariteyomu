class AddDisplayToLibrary < ActiveRecord::Migration[6.1]
  def change
    add_column :libraries, :display, :string
  end
end
