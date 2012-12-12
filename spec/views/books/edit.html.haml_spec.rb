# encoding: utf-8
require 'spec_helper'

describe "books/edit.html.haml" do
  before do
    Book.delete_all
    @book = Book.create title: "ruby"
  end

  it "should display edit book form" do
    assign(:book, @book)
    
    render

    expect(rendered).to match /Book/

    assert_select "form", action: edit_book_path(@book), method: "post" do
      assert_select "input#book_title", name: "book[title]"
      assert_select "input#book_image_url", name: "book[image_url]"
      assert_select 'textarea#book_description', name: "book[description]"
      assert_select "input.btn.btn-primary", content: "保存"
    end
  end
end