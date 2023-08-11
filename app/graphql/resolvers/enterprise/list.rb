# frozen_string_literal: true

module Resolvers
  module Enterprise
    class List < BaseResolver
      type Types::Enterprise::ListType, null: false

      argument :id,
               Int,
               required: true,
               description: 'やりたいことリストID'

      def resolve(**_args)
        context[:current_user].lists.find(id)
      end

      def authorized?(**_args)
        context[:current_user].present?
      end
    end
  end
end
