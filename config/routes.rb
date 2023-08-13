# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql/enterprise', graphql_path: '/graphql/enterprise'
  end
  namespace :graphql do
    post 'enterprise', to: 'enterprise#execute'
  end
end
