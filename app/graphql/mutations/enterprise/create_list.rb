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
        list = context[:current_user].lists.build(uuid: SecureRandom.urlsafe_base64)
        list.save!

        { list: }
      end

      def authorized?(**_inputs)
        login? || raise(Errors::UnauthorizedError)
      end
    end
  end
end
