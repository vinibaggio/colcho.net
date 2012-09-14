class Review < ActiveRecord::Base
  POINTS = (1..5).to_a

  belongs_to :user
  belongs_to :room, :counter_cache => true
  attr_accessible :comment, :points

  validates_uniqueness_of :user_id, :scope => :room_id
  validates_presence_of :points, :user_id, :room_id
  validates_inclusion_of :points, :in => POINTS

  def self.stars
    (average(:points) || 0).round
  end
end
