class ChatsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @chat = Chat.new(message_params)
    @chat.save
    @room = Room.find(params[:chat][:room_id])
    @chats = @room.chats
    @chat = Chat.new
    @user = User.find(params[:chat][:u_id])
    respond_to do |format|
            format.html {redirect_back(fallback_location: root_path)}
            format.js
    end
  end
  
  private
  
  def message_params
    params.require(:chat).permit(:message, :room_id).merge(user_id: current_user.id)
  end
  
end
