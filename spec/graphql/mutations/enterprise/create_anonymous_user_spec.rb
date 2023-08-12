# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Enterprise::CreateAnonymousUser, type: :request do
  describe 'execute' do
    let!(:user) { create(:user) }
    let(:context) { { current_user: user } }
    let(:query) do
      <<~QUERY
        mutation CreateAnonymousUser($input:CreateAnonymousUserInput!) {
          createAnonymousUser(input:$input) {
            id
            uuid
          }
        }
      QUERY
    end

    context 'when valid input' do
      let(:variables) do
        { input: {} }
      end

      it 'returns created list' do
        result = EnterpriseSchema.execute(query:, context:, variables:)
        expect(result.to_h.deep_symbolize_keys).to match(
          {
            data: {
              createAnonymousUser: {
                id: User.last.id,
                uuid: be_present
              }
            }
          }
        )
      end

      it 'creates user' do
        EnterpriseSchema.execute(query:, context:, variables:)

        user = User.last
        expect(user).to be_present
        expect(user.user_digest).to be_present
      end
    end
  end
end
