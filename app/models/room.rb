class Room < ActiveRecord::Base
  extend FriendlyId

  has_many :reviews, :dependent => :destroy
  belongs_to :user

  attr_accessible :description, :location, :title, :picture

  validates_presence_of :description
  validates_presence_of :location
  validates_presence_of :title
  validates_presence_of :slug

  mount_uploader :picture, PictureUploader
  friendly_id :title, :use => [:slugged, :history]

  scope :most_recent, order('created_at DESC')

  def self.search(query)
    if query.present?
      where(['location ILIKE :query OR
              title ILIKE :query OR
              description ILIKE :query', :query => "%#{query}%"])
    else
      scoped
    end
  end

  def complete_name
    "#{title}, #{location}"
  end
end
