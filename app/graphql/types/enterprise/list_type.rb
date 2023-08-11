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

      def user
        load_object_association(:user)
      end

      def items
        load_object_association(:items)
      end
    end
  end
end
