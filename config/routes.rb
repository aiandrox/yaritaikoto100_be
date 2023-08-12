# frozen_string_literal: true

Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql/enterprise', graphql_path: '/graphql/enterprise'
  end
  namespace :graphql do
    post 'enterprise', to: 'enterprise#execute'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
