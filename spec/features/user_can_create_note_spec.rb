# coding: utf-8
require 'spec_helper'

feature 'ユーザとして、本にノートを付けたい' do
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
    
    background  do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:twitter] = mock_hash

      User.delete_all
      Book.delete_all

      user = User.create! name: 'testuser'

      @book = Book.create title: 'ruby', description: "I's beautiful language", created_by: user

      5.times.map.with_index(1) { |i| @book.notes.build page: i*10, note: "note #{i}", user: user}
      @book.save

      visit root_path
      click_link "Twitterでログイン"
    end

    scenario 'ページとノート内容を入力して、ノートを登録出来る' do
      click_link @book.title

      @book.notes.each do |note|
        page.should have_content note.page
        page.should have_content note.note
      end

      click_link "ノートを追加"
      fill_in 'note_page', with: '101'
      fill_in 'note_note', with: '新しいノート'

      click_button "保存"

      page.should have_content 101
      page.should have_content '新しいノート'
    end
  end

  context "ログインしていない場合" do
    background do
      user = User.create! name: 'testuser'

      @book = Book.create title: 'ruby', description: "I's beautiful language", created_by: user

      5.times.map.with_index(1) { |i| @book.notes.build page: i*10, note: "note #{i}", user: user}
      @book.save
    end
    
    scenario 'ノート追加リンクが表示されない' do
      visit root_path
      click_link @book.title

      @book.notes.each do |note|
        page.should have_content note.page
        page.should have_content note.note
      end

      page.should_not have_content "ノートを追加"
    end
  end
end