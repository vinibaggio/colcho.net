class Room < ActiveRecord::Base
  extend FriendlyId

  has_many :reviews, dependent: :destroy
  belongs_to :user

  validates_presence_of :title
  validates_presence_of :slug

  mount_uploader :picture, PictureUploader
  friendly_id :title, use: [:slugged, :history]

  def self.search(query)
    if query.present?
      where(['location ILIKE :query OR
              title ILIKE :query OR
              description ILIKE :query', query: "%#{query}%"])
    else
      all
    end
  end

  def self.most_recent
    order(created_at: :desc)
  end

  def complete_name
    "#{title}, #{location}"
  end
end
