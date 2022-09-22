class PostCategory < ApplicationRecord
  belongs_to :post
  belongs_to :category
  validates :post_id, uniqueness: { scope: :author_id }
end
