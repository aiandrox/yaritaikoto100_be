# frozen_string_literal: true

module Types
  module Enterprise
    class UserType < Types::BaseObject
      description 'ユーザー'

      field :id,
            Int,
            null: false,
            description: 'ユーザーID'

      field :name,
            String,
            null: false,
            description: 'ユーザー名'
    end
  end
end
