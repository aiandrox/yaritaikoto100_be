# frozen_string_literal: true

module Graphql
  class EnterpriseController < ApplicationController
    # If accessing from outside this domain, nullify the session
    # This allows for outside API access while preventing CSRF attacks,
    # but you'll have to authenticate your user separately
    # protect_from_forgery with: :null_session
    include ::ActionController::Cookies

    def execute
      variables = prepare_variables(params[:variables])
      query = params[:query]
      operation_name = params[:operationName]
      context = {
        current_user:
      }
      result = EnterpriseSchema.execute(query, variables:, context:,
                                               operation_name:)
      render json: result
    rescue StandardError => e
      raise e unless Rails.env.development?

      handle_error_in_development(e)
    end

    private

    # Handle variables in form data, JSON body, or a blank value
    def prepare_variables(variables_param)
      case variables_param
      when String
        if variables_param.present?
          JSON.parse(variables_param) || {}
        else
          {}
        end
      when Hash
        variables_param
      when ActionController::Parameters
        variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
      when nil
        {}
      else
        raise ArgumentError, "Unexpected parameter: #{variables_param}"
      end
    end

    def handle_error_in_development(error)
      logger.error error.message
      logger.error error.backtrace.join("\n")

      render json: { errors: [{ message: error.message, backtrace: error.backtrace }], data: {} },
             status: :internal_server_error
    end

    def current_user
      return @current_user if defined?(@current_user)

      access_token = cookies[:access_token]

      if access_token.nil?
        Rails.logger.info 'access_token is nil'
        return
      end

      payload = JWT.decode(access_token, ENV.fetch('ACCESS_TOKEN_SECRET_KEY')).first
      @current_user = User.find_by!(id: payload['sub'], access_token:)
    end
  end
end
