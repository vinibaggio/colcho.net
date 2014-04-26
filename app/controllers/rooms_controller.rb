class RoomsController < ApplicationController
  PER_PAGE = 10
  
  before_action :set_room, only: [:show]
  before_action :set_users_room, only: [:edit, :update, :destroy]
  before_action :require_authentication,
    only: [:new, :edit, :create, :update, :destroy]

  def index
    @search_query = params[:q]
    
    rooms = Room.search(@search_query).
      most_recent.
      page(params[:page]).
      per(PER_PAGE)
    
    @rooms = RoomCollectionPresenter.new(rooms, self)
  end

  def show
    if user_signed_in?
      @user_review = @room.reviews.
        find_or_initialize_by(user_id: current_user.id)
    end
  end

  def new
    @room = current_user.rooms.build
  end

  def edit
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      redirect_to @room, notice: t('flash.notice.room_created')
    else
      render :new
    end
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: t('flash.notice.room_updated')
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_url
  end

  private
  def set_room
    room_model = Room.friendly.find(params[:id])
    @room = RoomPresenter.new(room_model, self)
  end

  def set_users_room
    @room = current_user.rooms.friendly.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:title, :location, :descriptio, :picture)
  end
end
