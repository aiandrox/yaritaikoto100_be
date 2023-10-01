# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                   :bigint           not null, primary key
#  confirmation_sent_at :datetime
#  confirmation_token   :string(255)
#  confirmed_at         :datetime
#  email                :string(255)      default(""), not null
#  encrypted_password   :string(255)      default(""), not null
#  image                :string(255)
#  name                 :string(255)
#  nickname             :string(255)
#  provider             :string(255)      default("email"), not null
#  tokens               :text(65535)
#  uid                  :string(255)      default(""), not null
#  unconfirmed_email    :string(255)
#  user_digest          :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_users_on_email             (email) UNIQUE
#  index_users_on_uid_and_provider  (uid,provider) UNIQUE
#
class User < ApplicationRecord
  has_many :lists, dependent: :destroy

  class << self
    def from_omniauth(access_token)
      data = access_token.info
      user = User.where(email: data['email']).first

      user ||= User.create(
        email: data['email']
      )
      user
    end
  end
end
