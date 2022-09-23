class Post < ApplicationRecord
  belongs_to :user

  has_many :post_authors, dependent: :destroy
  has_many :post_categories, dependent: :destroy
  has_many :authors, through: :post_authors
  has_many :categories, through: :post_categories
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }

  def save_with_author(authors)
    ActiveRecord::Base.transaction do
      self.save!
      self.authors = authors.uniq.reject(&:blank?).map { |name| Author.find_or_initialize_by(name: name.strip) } unless authors.nil?
    end
    true
    rescue StandardError
      false
  end
end
