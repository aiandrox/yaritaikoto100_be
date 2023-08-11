# frozen_string_literal: true

module Types
  module Enterprise
    class UserType < Types::BaseObject
      description 'ユーザー'

      field :id,
            Int,
            null: false,
            description: 'ユーザーID'
    end
  end
end
