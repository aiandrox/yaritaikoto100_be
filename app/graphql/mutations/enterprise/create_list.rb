# frozen_string_literal: true

module Mutations
  module Enterprise
    class CreateList < Mutations::BaseMutation
      description <<~DESC
        やりたいことリストを作成する。
      DESC

      field :list,
            Types::Enterprise::ListType,
            null: false,
            description: '作成したやりたいことリスト情報'

      def resolve(**_args)
        list = List.create_with_items!(context[:current_user])

        { list: }
      end
    end
  end
end
