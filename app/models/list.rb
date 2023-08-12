# frozen_string_literal: true

# == Schema Information
#
# Table name: lists
#
#  id         :bigint           not null, primary key
#  published  :boolean          default(TRUE), not null
#  title      :string(255)      not null
#  uuid       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_lists_on_user_id  (user_id)
#  index_lists_on_uuid     (uuid) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class List < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :uuid, presence: true, uniqueness: true
  validates :title, presence: true, length: { maximum: 15 }

  def self.create_with_items!(user)
    list = new(user_id: user.id, uuid: SecureRandom.urlsafe_base64, title: 'やりたいことリスト')
    ActiveRecord::Base.transaction do
      list.save!
      item_hash = (1..100).map do |number|
        { list_id: list.id, number:, name: '' }
      end
      Item.insert_all(item_hash, record_timestamps: true)
    end
    list
  end
end
