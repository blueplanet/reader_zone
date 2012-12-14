# encoding: utf-8
require 'spec_helper'

describe "books/show" do
  let(:user1) {User.create name: "testuser1"}
  let(:user2) {User.create name: "testuser2"}

  before do
    Book.delete_all
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
    book.save
    
    book
  end

  before do
    assign(:book, book)
    assign(:current_user, false)
  end

  it "should display detail of book" do
    render

    expect(rendered).to match /img/
    expect(rendered).to match /The Ruby Programming/
    expect(rendered).to match /はじめに/
    expect(rendered).to match /testuser1/
  end

  it "should display note list" do
    render

    expect(rendered).to match /10/
    expect(rendered).to match /testuser1/
    expect(rendered).to match /note test/
    expect(rendered).to match /100/
    expect(rendered).to match /testuser2/
    expect(rendered).to match /note test 22/
  end

  it "should display link to new note" do
    render

    assert_select "a", content: "ノートを追加"
  end

  it "should display link to only my notes" do
    render

    assert_select "a", content: "自分の0み"
  end

  context "with login user" do
    before do
      assign(:current_user, user1)
    end

    it "should display edit link for owner's note" do
      render

      assert_select 'a.btn', content: "編集"
    end
  end
end