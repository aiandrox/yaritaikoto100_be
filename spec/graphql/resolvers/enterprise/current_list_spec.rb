# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resolvers::Enterprise::CurrentList, type: :request do
  describe 'resolve' do
    let!(:user) { create(:user) }
    let(:context) { { current_user: user } }
    let(:query) do
      <<~QUERY
        query CurrentList {
          currentList {
            uuid
            title
            published
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
      {}
    end

    context 'when exist my list' do
      let!(:list) { create(:list, user:) }
      let!(:item) { create(:item, list:) }

      it 'return expected list' do
        result = EnterpriseSchema.execute(query:, context:, variables:)
        expect(result.to_h.deep_symbolize_keys).to eq(
          {
            data: {
              currentList: {
                uuid: list.uuid,
                title: list.title,
                published: list.published,
                items: [
                  {
                    number: item.number,
                    name: item.name,
                    doneAt: nil
                  }
                ]
              }
            }
          }
        )
      end
    end

    context 'when not exist my list' do
      before do
        list = create(:list)
        create(:item, list:)
      end

      it 'return error' do
        result = EnterpriseSchema.execute(query:, context:, variables:)
        expect(result.to_h.deep_symbolize_keys).to eq(
          {
            data: nil,
            errors: [
              {
                message: 'Cannot return null for non-nullable field Query.currentList'
              }
            ]
          }
        )
      end
    end
  end
end
