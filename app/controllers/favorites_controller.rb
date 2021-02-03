class FavoritesController < ApplicationController
    before_action :authenticate_user!
    
    def create
        @book = Book.find(params[:book_id])
        @favorite = current_user.favorites.create(book_id: params[:book_id])
        respond_to do |format|
            format.html {redirect_back(fallback_location: root_path)}
            format.js
        end
    end
    
    def destroy
        @book = Book.find(params[:book_id])
        @favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
        @favorite.destroy
        respond_to do |format|
            format.html {redirect_back(fallback_location: root_path)}
            format.js
        end
    end
    
end
