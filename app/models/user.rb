class User < ApplicationRecord
  authenticates_with_sorcery!

  mount_uploader :avatar, AvatarUploader

  has_many :books, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  has_many :active_relationships, class_name: :Relationship, foreign_key: :followed_id, dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: :Relationship, foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :followed

  has_many :libraries, dependent: :destroy
  # has_many :libraries, through: :user_libraries

  validates :password, length: { minimum: 4 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 16 }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true
  validates :introduction, length: { maximum: 1000 }

  def own?(object)
    id == object.user_id
  end

  def like(post)
    like_posts << post
  end
 
  def unlike(post)
    like_posts.destroy(post)
  end
 
  def like?(post)
    like_posts.include?(post)
  end

  def following?(user)
    followings.include?(user)
  end
  
  def follow(other_user)
    followings << other_user
  end
  
  def unfollow(user)
    active_relationships.find_by(follower_id: user.id).destroy!
  end
end
