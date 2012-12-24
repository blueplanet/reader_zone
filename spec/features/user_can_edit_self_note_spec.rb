# coding: utf-8
require 'spec_helper'

feature 'ユーザとして、自分のノートを編集したい' do
  context "ログインしている場合" do
    def mock_hash
      {
        "provider" => "twitter",
        "uid" => 1234567, 
        "info" => {
          "nickname" => 'test_user_twitter', 
          "image" => '...test.png'
        }
      }
    end

    background do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:twitter] = mock_hash

      User.delete_all
      Book.delete_all

      @user1 = User.create! provider: mock_hash["provider"], uid: mock_hash["uid"], name: mock_hash["info"]["nickname"]
      @user2 = User.create! name: 'testuser2'
      @user3 = User.create! name: 'testuser3'

      @book = Book.create! title: 'ruby', description: "I's beautiful language", created_by:@user1 

      5.times.map.with_index(1) { |i| @book.notes.build page: i*10, note: "note #{i}", user: @user1}

      @book.notes[0].user =@user2 
      @book.notes[2].user =@user3 
      @book.notes[4].user =@user2 

      @book.save

      visit root_path
      click_link "Twitterでログイン"

      click_link @book.title
    end

    scenario '自分のノートに対して編集ページへ遷移出来る' do
      page.should have_content "編集"

      first(:link, "編集").click

      page.should have_field "note_page", with: @book.notes[1].page.to_s
      page.should have_field "note_note", with: @book.notes[1].note
    end
  end
end