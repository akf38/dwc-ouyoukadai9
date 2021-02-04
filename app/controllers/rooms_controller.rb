class RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @room = Room.create
    @user_room_for_cu = UserRoom.create(user_id: current_user.id, room_id: @room.id)
    @user_room_for_u = UserRoom.create(user_id: params[:user_id], room_id: @room.id)
    redirect_to @room
  end
  
  def show
    @room = Room.find(params[:id])
    @room.user_room.each do |r|
      unless r.user_id == current_user.id
        @user = User.find(r.user_id)
      end
    end
    if UserRoom.where(user_id: current_user.id, room_id: @room.id).present?
      @chats = @room.chats
      @chat = Chat.new
      @user_rooms = @room.user_room
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
  def user_id_params
    params.require(:user_room).permit(:user_id)
  end
end
