require 'spec_helper'

describe "books/index.html.haml" do
  it "display all books" do
    render
    expect(rendered).to match /Books/
  end
end