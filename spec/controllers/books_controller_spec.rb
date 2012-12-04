require 'spec_helper'

describe BooksController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "should assign @books" do
      Book.delete_all
      book = Book.create image_url: "test.png", title: "Ruby", description: "This is a language"

      get 'index'

      assigns(:books).should eq([book])
    end

    it "should render index template" do
      get 'index'
      response.should render_template("index")
    end
  end

  describe "GET 'show'" do
    let(:book) { Book.create( image_url: "test.png", title: "Ruby", description: "I's a language")}

    it "return http success" do
      get 'show', {id: book.id}
      response.should be_success
    end

    it "should assigns @book" do
      get 'show', {id: book.id}

      assigns[:book].should eq(book)
    end

    it "should render show template" do
      get 'show', {id: book.id}
      response.should render_template("show")
    end
  end
end
