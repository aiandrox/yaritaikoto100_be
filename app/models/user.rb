# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string(255)      not null
#  name       :string(255)      not null
#  uid        :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_uid    (uid) UNIQUE
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
