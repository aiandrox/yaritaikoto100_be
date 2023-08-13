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
              items {
                number
                name
              }
            }
          }
        }
      QUERY
    end

    context 'when valid input' do
      let(:variables) do
        {
          input: {
            items: %w[北海道旅行に行く 沖縄旅行に行く]
          }
        }
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
                  items: [
                    {
                      number: 1,
                      name: '北海道旅行に行く'
                    },
                    {
                      number: 2,
                      name: '沖縄旅行に行く'
                    }
                  ]
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
        expect(list.published).to be true
      end

      it 'creates items' do
        EnterpriseSchema.execute(query:, context:, variables:)

        item = Item.first
        expect(item.number).to eq 1
        expect(item.name).to eq '北海道旅行に行く'

        item = Item.last
        expect(item.number).to eq 2
        expect(item.name).to eq '沖縄旅行に行く'
      end
    end
  end
end
