# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :current_list,
          resolver: Resolvers::Enterprise::CurrentList,
          description: '最新のリスト情報'

    field :current_user,
          resolver: Resolvers::Enterprise::CurrentUser,
          description: 'ログインユーザー情報'
  end
end
