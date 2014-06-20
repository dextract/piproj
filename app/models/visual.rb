class Visual < ActiveRecord::Base
  belongs_to :user
  has_many :visual_utilizations
  has_many :utilized_by, through: :visual_utilizations, source: :content
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  scope :videos, -> { where(type: 'Video') }
  scope :images, -> { where(type: 'Image') }

  self.inheritance_column = :type

  class << self
    def types
      %w(video image)
    end
  end

end
