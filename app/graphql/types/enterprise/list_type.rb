# frozen_string_literal: true

module Types
  module Enterprise
    class ListType < Types::BaseObject
      description 'やりたいことリスト'

      field :user,
            UserType,
            null: false,
            description: 'ユーザ'

      field :id,
            Int,
            null: false,
            description: 'やりたいことリストID'

      field :items,
            [ItemType],
            null: false,
            description: 'やりたいことリストの項目'
    end
  end
end
