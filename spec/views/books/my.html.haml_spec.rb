# encoding: utf-8
require 'spec_helper'

describe "books/show" do
  let(:user1) {User.create name: "testuser1"}
  let(:user2) {User.create name: "testuser2"}

  before do
    Book.delete_all
    view.stub(:current_user) {user1}
  end

  let(:book) do
    book = Book.create(
      image_url: "http://www.rubyinside.com/wp-content/uploads/2008/02/hummingbird-book-the-ruby-programming-language.jpg",
      title: "The Ruby Programming",
      description: "はじめに",
      created_by: user1
    )

    book.notes.build page: 10, note: "note test", user: user1
    book.notes.build page: 100, note: "note test 22", user: user2

    book
  end

  it "should display detail of book" do
    assign(:book, book)
    assign(:notes, book.notes)

    render

    expect(rendered).to match /img/
    expect(rendered).to match /The Ruby Programming/
    expect(rendered).to match /はじめに/
  end

  it "should display note list" do
    assign(:book, book)
    assign(:notes, book.notes.first)

    render

    expect(rendered).to match /10/
    expect(rendered).to match /testuser1/
    expect(rendered).to match /note test/
  end

  it "should display link to new note" do
    assign(:book, book)
    assign(:notes, book.notes)

    render

    assert_select "a", content: "ノートを追加"
  end
end