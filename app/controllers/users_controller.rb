class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    
    @current_user_user_room = UserRoom.where(user_id: current_user.id)
    @user_user_room = UserRoom.where(user_id: @user.id)
    
    unless @user.id == current_user.id
      @current_user_user_room.each do |cu|
        @user_user_room.each do |u|
          if cu.room_id == u.room_id then
            @isroom = true
            @roomid = cu.room_id
          end
        end
      end
    end
    
    unless @isroom
      @room = Room.new
      @user_room = UserRoom.new
    end
      
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end
  
  def following
    @user = User.find(params[:id])
    @users = @user.following
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :postcode, :prefecture_name, :address_city, :address_street)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
end
