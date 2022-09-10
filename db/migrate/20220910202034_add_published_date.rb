class AddPublishedDate < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :published_date, :string
		add_column :books, :remote_book_image, :string
    add_column :books, :info_link, :text
  end
end
