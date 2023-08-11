# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resolvers::Enterprise::CurrentList, type: :request do
  describe 'resolve' do
    let!(:user) { create(:user) }
    let(:context) { { current_user: user } }
    let(:query) do
      <<~QUERY
        query CurrentListQuery {
          currentList {
            id
            items {
              number
              name
              doneAt
            }
          }
        }
      QUERY
    end
    let(:variables) do
      { }
    end

    context 'when exist my list' do
      let!(:list) { create(:list, user:) }
      let!(:item) { create(:item, list:) }

      it 'return expected list' do
        result = EnterpriseSchema.execute(query:, context:, variables:)
        expect(result.to_h.deep_symbolize_keys[:data]).to eq({
          currentList: {
            id: list.id,
            items: [
              {
                number: item.number,
                name: item.name,
                doneAt: item.done_at.iso8601
              }
            ]
          }
        })
      end
    end

    context 'when not exist my list' do
      before do
        list = create(:list)
        create(:item, list:)
      end

      it 'return expected list' do
        result = EnterpriseSchema.execute(query:, context:, variables:)
        expect(result.to_h.deep_symbolize_keys[:data]).to eq(nil)
      end
    end
  end
end
