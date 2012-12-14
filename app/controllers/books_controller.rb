class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(params[:book])
    
    if @book.save
      redirect_to @book
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
    if current_user.nil? || current_user.id != @book.created_by.id
      redirect_to @book
    end
  end

  def update
    @book = Book.find(params[:id])
    if current_user != @book.created_by
      redirect_to @book
    else
      if @book.update_attributes(params[:book])
        redirect_to @book
      else
        render :edit
      end
    end
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
