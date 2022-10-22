class Post < ApplicationRecord
  belongs_to :user

  has_many :post_authors, dependent: :destroy
  has_many :authors, through: :post_authors

  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  has_many :comments, dependent: :destroy

  has_many :post_ages, dependent: :destroy
  has_many :ages, through: :post_ages

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validate :check_number_of_categories

  def check_number_of_categories
   if categories && post_categories.count > 5
    errors.add(:base,"カテゴリーは5個以内にしてください")
   end
  end

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
