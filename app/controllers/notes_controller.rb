class NotesController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
  end

  def create
    @book = Book.find(params[:book_id])
    note = @book.notes.build(params[:note])
    note.user = current_user
    note.save
    
    redirect_to @book
  end
end
