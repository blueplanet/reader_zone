require 'spec_helper'

describe "Notes" do
  describe "GET /books/1/notes/new" do
    it "status should success" do
      get new_book_note_path(2)
      response.status.should be(200)
    end
  end
end
