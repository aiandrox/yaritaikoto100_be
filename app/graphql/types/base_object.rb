# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)
    field_class Types::BaseField

    private

    def load_object_association_promise(association)
      Helpers::AssociationLoader.for(object.class, association).load(object)
    end

    def load_object_associations_promise(*associations)
      Promise.all(associations.map { |association| load_object_association_promise(association) })
    end

    def load_object_association(association)
      load_object_association_promise(association).then { |record| record }
    end
  end
end
