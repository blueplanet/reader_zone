require 'spec_helper'

describe NotesController do

  describe "GET 'new'" do
    let(:book) { Book.create! title: "Ruby" }

    it "returns http success" do
      get 'new', {book_id: book.id}
      response.should be_success
    end

    it "should assigns @book and @note" do
      get :new, {book_id: book.id }

      assigns[:book].should eq(book)
    end
  end

end
