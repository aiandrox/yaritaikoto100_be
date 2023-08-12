# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    include Helpers::SessionHelper

    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    # NOTE: 認可処理を実装する
    def authorized?(**_inputs)
      raise NotImplementedError
    end
  end
end
