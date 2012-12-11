class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @notes = @book.notes
  end

  def my
    @book = Book.find(params[:id])
    @notes = @book.notes.of_user(current_user)
  end
end
