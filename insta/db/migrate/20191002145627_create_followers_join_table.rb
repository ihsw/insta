class CreateFollowersJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :followers, id: false do |t|
      t.bigint :follower_id
      t.bigint :user_id
    end

    add_index :followers, :follower_id
    add_index :followers, :user_id
  end
end
