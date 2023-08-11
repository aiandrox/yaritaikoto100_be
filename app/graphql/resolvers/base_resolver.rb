# frozen_string_literal: true

module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    # NOTE: 認可処理を実装する
    def authorized?(**_inputs)
      raise NotImplementedError
    end
  end
end
