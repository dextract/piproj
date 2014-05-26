class User < ActiveRecord::Base
  has_many :bookmarks
  has_many :contents, through: :bookmarks
  has_many :contents
end