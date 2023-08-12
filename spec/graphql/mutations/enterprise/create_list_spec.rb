# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Enterprise::CreateList, type: :request do
  describe 'execute' do
    let!(:user) { create(:user) }
    let(:context) { { current_user: user } }
    let(:query) do
      <<~QUERY
        mutation CreateList($input:CreateListInput!) {
          createList(input:$input) {
            list {
              uuid
              published
            }
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
              createList: {
                list: {
                  uuid: be_present,
                  published: true,
                }
              }
            }
          }
        )
      end

      it 'creates list' do
        EnterpriseSchema.execute(query:, context:, variables:)

        list = List.last
        expect(list).to be_present
        expect(list.uuid).to be_present
        expect(list.published).to eq true
      end
    end
  end
end
