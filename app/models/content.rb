class Content < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks
  has_many :visual_utilizations
  has_many :bookmarked_by, through: :bookmarks, source: :user
  has_many :utilizations, through: :visual_utilizations, source: :visual
  scope :bibliotecas, -> { where(type: 'Biblioteca') }

  self.inheritance_column = :type

  class << self
    def types
      %w(biblioteca)
    end
  end

end