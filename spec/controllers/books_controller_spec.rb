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

end
