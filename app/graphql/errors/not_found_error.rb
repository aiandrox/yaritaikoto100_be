# frozen_string_literal: true

module Errors
  class NotFoundError < GraphQL::ExecutionError
    def initialize(message, ast_node: nil, options: nil, extensions: nil)
      super(message, ast_node:, options:, extensions:)
    end
  end
end
