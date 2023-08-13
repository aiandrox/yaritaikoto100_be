# frozen_string_literal: true

# https://github.com/lynndylanhurley/devise_token_auth/blob/master/app/controllers/devise_token_auth/omniauth_callbacks_controller.rb
module Users
  class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
    include Devise::Controllers::Rememberable

    def omniauth_success
      get_resource_from_auth_hash
      set_token_on_resource
      create_auth_params

      # if confirmable_enabled?
      #   # don't send confirmation email!!!
      #   @resource.skip_confirmation!
      # end

      # sign_in(:user, @resource, store: false, bypass: false)

      @resource.save!

      yield @resource if block_given?

      set_token_in_cookie(@resource, @token) if DeviseTokenAuth.cookie_enabled

      render json: @resource, status: :ok
    end

    protected

    # nameが存在しないクラスがあるため（多分GraphQL系クラス）
    def resource_class(_mapping = nil)
      return @resource_class if defined?(@resource_class)

      constant_name = omniauth_params['resource_class'].presence || params['resource_class'].presence
      @resource_class = constant_name.constantize
      @resource_class
    end

    def get_resource_from_auth_hash
      # find or create user by provider and provider uid
      @resource = resource_class.where(
        uid: auth_hash['uid'],
        provider: auth_hash['provider']
      ).first_or_initialize

      if @resource.new_record?
        @oauth_registration = true
        # パスワードはないので
        # handle_new_resource
      end

      # sync user info with provider, update/generate auth token
      assign_provider_attrs(@resource, auth_hash)

      # assign any additional (whitelisted) attributes
      if assign_whitelisted_params?
        extra_params = whitelisted_params
        @resource.assign_attributes(extra_params) if extra_params
      end

      @resource
    end
  end
end
