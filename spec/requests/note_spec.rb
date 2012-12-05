require 'spec_helper'

describe "Notes routing" do
  let(:book) {Book.create title: "Ruby" }

  describe "GET /books/1/notes/new" do
    it "status should success" do
      get new_book_note_path(book.id)
      response.status.should be(200)
    end
  end
end
