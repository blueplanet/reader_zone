require 'spec_helper'

describe "Notes routing" do
  let(:book) {Book.create title: "Ruby" }

  describe "GET /books/:book_id/notes/new" do
    it "status should success" do
      get new_book_note_path(book.id)
      response.status.should be(200)
    end
  end

  describe "GET /books/:book_id/notes/:id/edit" do
    let(:note) {Note.create book: book, page: 100, note: 'note'}

    it "status should success" do
      get edit_book_note_path(book_id: book.id, id: note.id)
      response.status.should be(200)
    end
  end
end
