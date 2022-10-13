class Library < ApplicationRecord
  belongs_to :user
    # belongs_to :user
  # belongs_to :library
  validates :name, presence: true
end

