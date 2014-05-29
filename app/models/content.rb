class Content < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks
  has_many :bookmarked_by, through: :bookmarks, source: :user
  scope :videos, -> { where(type: 'Video') }

  self.inheritance_column = :type

  class << self
    def types
      %w(video)
    end
  end

end