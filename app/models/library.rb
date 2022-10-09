class Library < ApplicationRecord
  has_many :user_libraries, dependent: :destroy
  has_many :users, through: :user_libraries, source: :user

  validates :name, presence: true
end

