# frozen_string_literal: true

module Errors
  class UnauthorizedError < GraphQL::ExecutionError
    def initialize(message = 'unauthorized', ast_node: nil, options: nil, extensions: nil)
      super(message, ast_node:, options:, extensions:)
    end
  end
end
