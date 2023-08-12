# frozen_string_literal: true

module Errors
  class BadRequestError < GraphQL::ExecutionError
    def initialize(message = 'bad request', ast_node: nil, options: nil, extensions: nil)
      super(message, ast_node:, options:, extensions:)
    end
  end
end
