# frozen_string_literal: true

module Types
  module Enterprise
    class ItemType < Types::BaseObject
      description 'やりたいことリストの項目'

      field :list,
            ListType,
            null: false,
            description: 'やりたいことリスト'

      field :number,
            Int,
            null: false,
            description: 'リスト番号'

      field :name,
            String,
            null: false,
            description: 'やりたいこと'

      field :done_at,
            GraphQL::Types::ISO8601DateTime,
            null: true,
            description: '完了日時'
    end
  end
end
