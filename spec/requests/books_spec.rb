require 'spec_helper'

describe BooksController, "GET /books/1/my" do
  let(:user) {User.create! name: 'testuser'}
  let(:book) {Book.create! title: "Ruby" }

  describe "GET book#my" do
    it "status should success" do
      get my_notes_book_path(id: book.id), {user_id: user.id}
      response.status.should be(200)
    end
  end

end