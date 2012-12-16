# encoding: utf-8
require 'spec_helper'

describe "books/index.html.haml" do
  it "display all books" do
    assign(:books, [
      stub_model(Book, 
        image_url: "http://books.shoeisha.co.jp//images/book/94964.jpg",
        title: "The RSpec Book",
        description: "ドキュメントを書くようにプログラミング！"
      ),
      stub_model(Book, 
        image_url: "http://www.rubyinside.com/wp-content/uploads/2008/02/hummingbird-book-the-ruby-programming-language.jpg",
        title: "The Ruby Programming",
        description: "はじめに"
      )
    ])
    render
    
    expect(rendered).to match /img/
    expect(rendered).to match /The RSpec Book/
    expect(rendered).to match /ドキュメントを書くように/

    expect(rendered).to match /The Ruby Programming/
    expect(rendered).to match /はじめに/
  end

end