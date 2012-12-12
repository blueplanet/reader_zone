# encoding: utf-8
require 'spec_helper'

describe "books/new.html.haml" do
  it "should display new book form" do
    assign(:book, stub_model(Book).as_new_record)
    
    render

    expect(rendered).to match /Book/

    assert_select "form", action: new_book_path, method: "post" do
      assert_select "input#book_title", name: "book[title]"
      assert_select "input#book_image_url", name: "book[image_url]"
      assert_select 'textarea#book_description', name: "book[description]"
      assert_select "input.btn.btn-primary", content: "作成"
    end
  end
end