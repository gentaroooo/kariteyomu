class Library < ApplicationRecord
  has_many :users, dependent: :destroy
    # belongs_to :user
  # belongs_to :library
  validates :name, presence: true
end

