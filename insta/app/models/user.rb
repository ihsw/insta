class User < ApplicationRecord
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  has_and_belongs_to_many :users, join_table: 'followers', association_foreign_key: :follower_id

  def followers
    users
  end

  def follow(target)
    users << target
  end

  def unfollow(target)
    users.delete target
  end
end
