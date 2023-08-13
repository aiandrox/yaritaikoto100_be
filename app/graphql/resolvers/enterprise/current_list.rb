# frozen_string_literal: true

module Resolvers
  module Enterprise
    class CurrentList < BaseResolver
      type Types::Enterprise::ListType, null: false

      def resolve(**_args)
        context[:current_user].lists.order(updated_at: :desc).first
      end
    end
  end
end
