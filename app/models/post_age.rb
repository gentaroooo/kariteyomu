class PostAge < ApplicationRecord
  belongs_to :post
  belongs_to :age

  validates :age_id, uniqueness: { scope: :post_id }
end
