# frozen_string_literal: true

module Mutations
  module Enterprise
    class UpsertItem < Mutations::BaseMutation
      description <<~DESC
        やりたいことリスト項目を追加・更新する。
      DESC

      argument :list_uuid,
               String,
               required: true,
               description: 'やりたいことリストID'

      argument :number,
               Int,
               required: true,
               description: 'リスト番号'

      argument :name,
               String,
               required: false,
               description: 'やりたいこと'

      argument :done_at,
               GraphQL::Types::ISO8601DateTime,
               required: false,
               description: '完了日時'

      field :item,
            Types::Enterprise::ItemType,
            null: false,
            description: '作成した項目'

      def resolve(**args)
        list = context[:current_user].lists.find_by!(uuid: args[:list_uuid])

        item = list.items.find_or_initialize_by(number: args[:number])
        item.assign_attributes(name: args[:name], done_at: args[:done_at])
        raise Errors::BadRequestError, item.error_sentence unless item.save

        { item: }
      end

      def authorized?(**_inputs)
        login?
      end
    end
  end
end
