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

    n1 = Note.new page: 10, note: "note test"
    n2 = Note.new page: 100, note: "note test 22"

    book.notes << n1
    book.notes << n2

    book
  end

  it "should display detail of book" do
    assign(:book, book)

    render

    expect(rendered).to match /img/
    expect(rendered).to match /The Ruby Programming/
    expect(rendered).to match /はじめに/

    expect(rendered).to match /10/
    expect(rendered).to match /note test/
    expect(rendered).to match /100/
    expect(rendered).to match /note test 22/
  end
end