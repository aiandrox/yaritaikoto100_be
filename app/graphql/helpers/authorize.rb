# frozen_string_literal: true

module Helpers
  module Authorize
    private

    def authenticate_user!
      return true if context[:current_user].present?

      raise Errors::UnauthenticatedError
    end
  end
end
