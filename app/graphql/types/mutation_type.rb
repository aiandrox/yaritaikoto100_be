# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    description 'MutationType'

    field :login_anonymous_user,
          mutation: ::Mutations::Enterprise::LoginAnonymousUser

    field :upsert_item,
          mutation: ::Mutations::Enterprise::UpsertItem

    field :create_list,
          mutation: ::Mutations::Enterprise::CreateList

    field :update_list,
          mutation: ::Mutations::Enterprise::UpdateList
  end
end
