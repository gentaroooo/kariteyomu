class PostAuthor < ApplicationRecord
  belongs_to :post
  belongs_to :author
  validates :post_id, uniqueness: { scope: :author_id }
end
