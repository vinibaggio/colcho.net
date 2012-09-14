module RoomsHelper
  def belongs_to_user(room)
    user_signed_in? && room.user == current_user
  end
end
