require 'spec_helper'

describe "notes/new.html.haml" do
  let(:book) { Book.create title: "Ruby" }
  let(:new_note) { stub_model(Note).as_new_record }

  before do
    assign(:book, book)
    assign(:note, new_note)
  end

  it "should display a new note form" do
    render
    # Run the generator post with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => new_book_note_path(1), :method => "post" do
      assert_select "input#note_page", name: "note[page]"
      assert_select "textarea#note_note", name: "note[note]"
    end
  end
end
