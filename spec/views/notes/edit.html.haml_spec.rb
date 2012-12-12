require 'spec_helper'

describe "notes/edit.html.haml" do
  before(:each) do
    Book.delete_all
  end
  
  let(:user) { User.create name: 'testuser'}
  let(:book) { Book.create title: "Ruby" }
  let(:note) { Note.create book: book, page: 100, note: 'saved note', user: user }

  before do
    assign(:book, book)
    assign(:note, note)
  end

  it "should display a edit note form" do
    render
    # Run the generator post with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => edit_book_note_path(1, 1), :method => "post" do
      assert_select "input#note_page", name: "note[page]"
      assert_select "textarea#note_note", name: "note[note]"
    end
  end

end
