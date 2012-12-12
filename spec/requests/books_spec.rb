require 'spec_helper'

describe BooksController do
  before do
    Book.delete_all
  end

  let(:user) {User.create! name: 'testuser'}
  let(:book) {Book.create! title: "Ruby" }

  describe "GET book#my" do
    it "status should success" do
      get my_notes_book_path(id: book.id), {user_id: user.id}
      response.status.should be(200)
    end
  end

  describe "GET book#new" do
    it "status should success" do
      get new_book_path, {user_id: user.id}
      response.status.should be(200)
    end
  end

  describe "GET book#edit" do
    it "status should success" do
      get edit_book_path(book)
      response.status.should be(200)
    end
  end
end