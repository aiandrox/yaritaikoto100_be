# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resolvers::Enterprise::CurrentList, type: :request do
  describe 'resolve' do
    let!(:user) { create(:user) }
    let(:context) { { current_user: user } }
    let(:query) do
      <<~QUERY
        query CurrentUserQuery {
          currentUser {
            id
            name
          }
        }
      QUERY
    end
    let(:variables) do
      {}
    end

    it 'return my info' do
      result = EnterpriseSchema.execute(query:, context:, variables:)
      expect(result.to_h.deep_symbolize_keys).to eq(
        {
          data: {
            currentUser: {
              id: user.id,
              name: user.name
            }
          }
        }
      )
    end
  end
end
