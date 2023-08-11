# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id         :bigint           not null, primary key
#  done_at    :datetime
#  name       :string(255)      not null
#  number     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  list_id    :bigint           not null
#
# Indexes
#
#  index_items_on_list_id  (list_id)
#
# Foreign Keys
#
#  fk_rails_...  (list_id => lists.id)
#
class Item < ApplicationRecord
  belongs_to :list
end
