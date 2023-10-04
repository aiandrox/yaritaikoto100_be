# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    if (user = User.find_or_create_from_auth_hash(auth_hash))
      # ヘッダーにアクセストークンをセットする
      update_access_token_with_set_cookie(user)
      redirect_to YaritaikotoUrl.instance.url('/callbacks')
    else
      raise
    end
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def update_access_token_with_set_cookie(user)
    expires_at = user.update_access_token!
    response.set_cookie(:access_token,
                        value: user.access_token,
                        expires: expires_at,
                        path: '/',
                        secure: true,
                        httponly: true)
    response.set_header('X-Access-Token', user.access_token)
    response.set_header('X-Expires', expires_at)
  end
end
