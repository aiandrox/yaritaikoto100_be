# frozen_string_literal: true

module Mutations
  module Enterprise
    class CreateList < Mutations::BaseMutation
      description <<~DESC
        やりたいことリストを作成する。
      DESC

      argument :items,
               [String],
               required: true,
               description: 'やりたいことリストの項目'

      field :list,
            Types::Enterprise::ListType,
            null: false,
            description: '作成したやりたいことリスト情報'

      def resolve(items:)
        list = List.create_default_value!(context[:current_user], items:)

        { list: }
      end
    end
  end
end
