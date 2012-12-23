# coding: utf-8
require "spec_helper"

feature 'ユーザとして、ある本に対して自分の付けたノート一覧が見える' do
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

      @user1 = User.create! uid: mock_hash["uid"], name: mock_hash["info"]["nickname"]
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
    end

    scenario '自分の作成したノートのみ表示される' do
      click_link @book.title

      page.should have_content @user1.name
      page.should have_content @user2.name
      page.should have_content @user3.name

      click_link "自分のノート"

      page.should have_content @user1.name
      page.should_not have_content @user2.name
      page.should_not have_content @user3.name
    end
  end
end