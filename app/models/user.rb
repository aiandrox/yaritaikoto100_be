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
  include DeviseTokenAuth::Concerns::User

  # Include default devise modules.
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable,
  #        :confirmable, :omniauthable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :lists, dependent: :destroy

  attr_accessor :uuid

  class << self
    def create_anonymous!
      uuid = new_uuid
      user = new(
        uuid:,
        user_digest: digest(uuid)
      )
      user.save!
      user
    end

    def from_omniauth(access_token)
      data = access_token.info
      user = User.where(email: data['email']).first

      unless user
        user = User.create(
          email: data['email'],
        )
      end
      user
    end

    private

    def new_uuid
      SecureRandom.urlsafe_base64
    end

    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost:)
    end
  end

  def authenticated?(uuid)
    BCrypt::Password.new(user_digest) == uuid
  end
end
