class NotesController < ApplicationController
  before_filter :get_book, only: [:new, :create, :edit, :update, :destroy]
  before_filter :get_note, only: [:edit, :update, :destroy]

  def new
  end

  def create
    note = @book.notes.build(params[:note])
    note.user = current_user
    note.save
    
    redirect_to @book
  end

  def edit
  end

  def update
    @note.update_attributes(params[:note])

    redirect_to book_path(@book)
  end

  def destroy
    @note.delete

    redirect_to book_path(@book)
  end

  private
  def get_book
    @book = Book.find(params[:book_id])
  end

  def get_note
    @note = Note.find(params[:id])
  end
end
