# frozen_string_literal: true

class YaritaikotoUrl
  include Singleton

  def url(path)
    URI.join(base_url, path).to_s
  end

  def base_url
    if Rails.env.production?
      'https://yaritaikoto100.vercel.app'
    else
      'http://localhost:9000'
    end
  end
end
