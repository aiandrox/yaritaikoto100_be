# frozen_string_literal: true

module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    include Helpers::Authorize

    def ready?(**_args)
      authenticate_user!
    end
  end
end
