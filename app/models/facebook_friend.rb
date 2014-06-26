class FacebookFriend < ActiveRecord::Base
  validates :name, presence: true
  has_one :facebook_user, foreign_key: :name, primary_key: :name
end
