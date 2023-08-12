# frozen_string_literal: true

module Errors
  class UnauthenticatedError < GraphQL::ExecutionError
    def initialize(message = 'unauthencated', ast_node: nil, options: nil, extensions: nil)
      super(message, ast_node:, options:, extensions:)
    end
  end
end
