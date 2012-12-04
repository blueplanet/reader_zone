# encoding: utf-8
class SessionsController < ApplicationController
  def callback
    auth = request.env["omniauth.auth"]

    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])

    notice = "ログインしました"

    if !user
      user = User.create_with_omniauth(auth) unless user
      notice = "#{auth["info"]["name"]}さんの#{auth["provider"]}アカウントと接続しました"
    end

    session[:user_id] = user.id
    redirect_to root_url, notice: notice
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "ログアウトしました"
  end
end
