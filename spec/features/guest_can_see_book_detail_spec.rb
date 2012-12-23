# coding: utf-8
require 'spec_helper'

feature 'ゲストとして、本の詳細情報を閲覧出来る' do
  background do
    Book.delete_all

    user = User.create name: 'testuser'

    5.times.map.with_index(1) { |i| Book.create! title: "book#{i}", created_by: user}
    @book = Book.first

    10.times.map.with_index(1) { |i| @book.notes.build page: i, note: "note #{i}", user: user}
    @book.save
  end

  scenario '本の詳細画面にアクセスすると、本の詳細情報が表示される' do
    visit book_path(@book)

    page.should have_content @book.image_url
    page.should have_content @book.title
    page.should have_content @book.description
  end

  scenario '本の詳細画面にアクセスすると、本のノート一覧が表示される' do
    visit book_path(@book)

    @book.notes.all do |note|
      page.should have_content note.page
      page.should have_content note.note
    end
  end
end