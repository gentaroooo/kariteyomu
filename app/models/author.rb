class Author < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors
  
  has_many :post_authors, dependent: :destroy
  has_many :posts, through: :post_authors

  validates :name, presence: true, uniqueness: true
end
