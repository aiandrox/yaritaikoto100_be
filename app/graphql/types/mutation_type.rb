# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    description 'MutationType'

      field :upsert_item,
            mutation: ::Mutations::Enterprise::UpsertItem
  end
end
