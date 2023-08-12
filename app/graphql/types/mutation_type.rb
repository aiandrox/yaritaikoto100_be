# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    description 'MutationType'

    field :create_anonymous_user,
          mutation: ::Mutations::Enterprise::CreateAnonymousUser

    field :upsert_item,
          mutation: ::Mutations::Enterprise::UpsertItem

    field :create_list,
          mutation: ::Mutations::Enterprise::CreateList

    field :update_list,
          mutation: ::Mutations::Enterprise::UpdateList
  end
end
