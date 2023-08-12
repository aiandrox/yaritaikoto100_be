# frozen_string_literal: true

module Mutations
  module Enterprise
    class UpdateList < Mutations::BaseMutation
      description <<~DESC
        やりたいことリストを更新する。
      DESC

      argument :uuid,
               String,
               required: true,
               description: 'やりたいことリストID'

      argument :published,
               Boolean,
               required: true,
               description: '公開状態'

      field :list,
            Types::Enterprise::ListType,
            null: false,
            description: '更新したやりたいことリスト情報'

      def resolve(uuid:, published:)
        list = context[:current_user].lists.find_by!(uuid:)

        list.assign_attributes(published:)
        raise Errors::BadRequestError, list.error_sentence unless list.save

        { list: }
      end

      def authorized?(**_inputs)
        login?
      end
    end
  end
end
