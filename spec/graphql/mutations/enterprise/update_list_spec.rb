# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Enterprise::UpdateList, type: :request do
  describe 'execute' do
    let!(:user) { create(:user) }
    let(:context) { { current_user: user } }
    let(:query) do
      <<~QUERY
        mutation UpdateList($input:UpdateListInput!) {
          updateList(input:$input) {
            list {
              uuid
              published
            }
          }
        }
      QUERY
    end

    context 'when valid input' do
      let!(:list) { create(:list, published: false, user:) }

      let(:variables) do
        {
          input: {
            uuid: list.uuid,
            published: true
          }
        }
      end

      it 'returns updated list' do
        result = EnterpriseSchema.execute(query:, context:, variables:)
        expect(result.to_h.deep_symbolize_keys).to eq(
          {
            data: {
              updateList: {
                list: {
                  uuid: list.uuid,
                  published: true
                }
              }
            }
          }
        )
      end

      it 'updates list' do
        EnterpriseSchema.execute(query:, context:, variables:)

        list = List.last
        expect(list).to be_present
        expect(list.published).to be true
      end
    end

    context 'when list is not mine' do
      let!(:list) { create(:list) }
      let(:variables) do
        {
          input: {
            uuid: list.uuid,
            published: true
          }
        }
      end

      it 'returns error' do
        result = EnterpriseSchema.execute(query:, context:, variables:)
        expect(result.to_h.deep_symbolize_keys).to eq(
          {
            data: {
              updateList: nil
            },
            errors: [
              {
                locations: [column: 3, line: 2],
                message: 'List not found',
                path: ['updateList']
              }
            ]
          }
        )
      end
    end
  end
end
