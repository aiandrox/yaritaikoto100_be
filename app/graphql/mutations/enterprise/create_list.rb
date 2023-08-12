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

      def resolve(**args)
        list = context[:current_user].lists.build(uuid: SecureRandom.uuid)
        list.save!

        { list: }
      end

      def authorized?(**_inputs)
        login?
      end
    end
  end
end