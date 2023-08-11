# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  user_digest :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class User < ApplicationRecord
end
