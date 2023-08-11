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
            String,
            null: false,
            method: :uuid,
            description: 'やりたいことリストID'

      field :published,
            Boolean,
            null: false,
            description: '公開状態'

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