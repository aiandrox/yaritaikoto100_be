module Errors
  module ErrorHandler
    rescue_from(ActiveRecord::RecordNotFound) do |err, obj, args, ctx, field|
      # Raise a graphql-friendly error with a custom message
      raise GraphQL::ExecutionError, "#{field.type.unwrap.graphql_name} not found"
    end
  end
end