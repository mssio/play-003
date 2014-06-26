class FacebookUser < ActiveRecord::Base
  validates :name, presence: true
end
