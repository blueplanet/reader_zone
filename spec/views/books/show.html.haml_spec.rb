# encoding: utf-8
require 'spec_helper'

describe "books/show" do
  before do
    Book.delete_all
  end

  let(:book) do
    book = Book.create(
      image_url: "http://www.rubyinside.com/wp-content/uploads/2008/02/hummingbird-book-the-ruby-programming-language.jpg",
      title: "The Ruby Programming",
      description: "はじめに"
    )

    book.notes.build page: 10, note: "note test"
    book.notes.build page: 100, note: "note test 22"

    book
  end

  it "should display detail of book" do
    assign(:book, book)

    render

    expect(rendered).to match /img/
    expect(rendered).to match /The Ruby Programming/
    expect(rendered).to match /はじめに/

  end

  it "should display note list of book" do
    assign(:book, book)

    render

    expect(rendered).to match /10/
    expect(rendered).to match /note test/
    expect(rendered).to match /100/
    expect(rendered).to match /note test 22/
  end

  it "should display link to new note" do
    assign(:book, book)

    render

    assert_select "a", content: "ノートを追加"
  end
end