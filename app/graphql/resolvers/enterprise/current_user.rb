# frozen_string_literal: true

module Resolvers
  module Enterprise
    class CurrentUser < BaseResolver
      type Types::Enterprise::UserType, null: true

      def resolve(**_args)
        context[:current_user]
      end
    end
  end
end
