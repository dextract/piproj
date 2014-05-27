class Content < ActiveRecord::Base
  has_many :bookmarks
  has_many :users, through: :bookmarks
  belongs_to :user
  scope :videos, -> { where(type: 'Video') }

  self.inheritance_column = :type

  class << self
    def types
      %w(video)
    end
  end

end