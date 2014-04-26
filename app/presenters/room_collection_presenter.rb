class RoomCollectionPresenter
  delegate :current_page, :num_pages, :limit_value, :total_pages,
    to: :@rooms

  def initialize(rooms, context)
    @rooms = rooms
    @context = context
  end

  def to_ary
    @rooms.map do |room|
      RoomPresenter.new(room, @context, false)
    end
  end
end
