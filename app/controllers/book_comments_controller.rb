class BookCommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:destroy]
    
    def create
        @book_comment = current_user.book_comments.new(book_id: params[:book_id], comment: params[:comment])
        if @book_comment.save
            redirect_back(fallback_location: root_path)
        else
            @book = Book.find(params[:book_id])
            @newbook = Book.new
            render 'books/show'
        end
    end
    
    def destroy
        @book_comment = BookComment.find(params[:id])
        @book_comment.destroy
        redirect_back(fallback_location: root_path)
    end
    
    private
    
    def ensure_correct_user
    @book_comment = BookComment.find(params[:id])
        unless @book_comment.user == current_user
        redirect_to book_path(@book_comment.book)
        end
    end
  
end
