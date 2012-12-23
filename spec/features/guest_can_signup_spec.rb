# coding: utf-8

feature 'ゲストとして、Twitterでログインしたい' do
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
  end

  context "登録してない場合" do
    background do
      User.delete_all
    end

    scenario 'ログインリンクでログイン出来る' do
      visit root_path

      page.should have_content "Twitterでログイン"

      click_link "Twitterでログイン"

      page.should have_content "test_user_twitter"
    end
  end

  context "登録した場合" do
    background do
      User.delete_all
      User.create_with_omniauth mock_hash
    end

    scenario 'ログインリンクでログイン出来る' do
      visit root_path

      page.should have_content "Twitterでログイン"

      click_link "Twitterでログイン"

      page.should have_content "test_user_twitter"
    end
  end
end