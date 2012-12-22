# coding: utf-8
require 'spec_helper'

feature 'ゲストとして、本の一覧を閲覧出来る' do
  background do
    Book.delete_all
    @user = User.create name: 'testuser'

    5.times.map.with_index(1) do |i| 
      new_book = Book.create! title: "book#{i}", created_by: @user

      i.times.map.with_index(1) {|j| new_book.notes.build page: j*10, note: "note #{j}", user: @user}
    end

  end

  scenario 'トップページにアクセスすると、本の一覧が表示される' do
    visit root_path

    Book.all.each do |book|
      page.should have_content book.image_url
      page.should have_content book.title
      page.should have_content book.description
      page.should have_content book.notes.count
    end
  end

  scenario '本の一覧場面から、本の詳細ページに遷移出来る' do
    book2 = Book.all[1]

    visit root_path

    click_link book2.title

    all(".book").count.should == 1
  end
end