# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  access_token :string(255)
#  email        :string(255)      not null
#  name         :string(255)      not null
#  uid          :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_uid    (uid) UNIQUE
#
class User < ApplicationRecord
  has_many :lists, dependent: :destroy

  class << self
    def find_or_create_from_auth_hash(auth_hash)
      User.where(uid: auth_hash.uid).first_or_create do |user|
        user.email = auth_hash.info.email
        user.name = auth_hash.info.name
      end
    end
  end

  def update_access_token!
    payload = {
      sub: id,
      exp: 1.week.since.end_of_day.to_i,
      iat: Time.current.to_i
    }
    access_token = JWT.encode(payload, ENV.fetch('ACCESS_TOKEN_SECRET_KEY'))
    update!(access_token:)
    Time.zone.at(payload[:exp])
  end
end
