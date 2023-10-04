# frozen_string_literal: true

Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql/enterprise', graphql_path: '/graphql/enterprise'
  end
  namespace :graphql do
    post 'enterprise', to: 'enterprise#execute'
  end
end
