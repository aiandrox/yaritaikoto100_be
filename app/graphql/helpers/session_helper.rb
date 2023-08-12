# frozen_string_literal: true

module Helpers
  module SessionHelper
    def login?
      context[:current_user].present?
    end
  end
end
