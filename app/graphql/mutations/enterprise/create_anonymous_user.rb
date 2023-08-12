# frozen_string_literal: true

module Mutations
  module Enterprise
    class CreateAnonymousUser < Mutations::BaseMutation
      description <<~DESC
        匿名ユーザーを作成する。
      DESC

      field :id,
            Int,
            null: false,
            description: 'ユーザーID'

      field :uuid,
            String,
            null: false,
            description: '匿名ユーザーのUUID'

      def resolve(**_args)
        user = User.create_anonymous!

        { id: user.id, uuid: user.uuid }
      end

      def authorized?(**_inputs)
        true
      end
    end
  end
end
