# frozen_string_literal: true

module Resolvers
  module Enterprise
    class CurrentList < BaseResolver
      type Types::Enterprise::ListType, null: true

      def resolve(**_args)
        context[:current_user].lists.order(updated_at: :desc).first
      end

      def authorized?(**_args)
        login?
      end
    end
  end
end
