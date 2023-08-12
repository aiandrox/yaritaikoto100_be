# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Enterprise::UpsertItem, type: :request do
  describe 'execute' do
    let!(:user) { create(:user) }
    let(:context) { { current_user: user } }
    let(:query) do
      <<~QUERY
        mutation UpsertItem($input:UpsertItemInput!) {
          upsertItem(input:$input) {
            item {
              number
              name
              doneAt
            }
          }
        }
      QUERY
    end

    context 'when valid input' do
      let!(:list) { create(:list, user:) }

      context 'when item not exists' do
        let(:variables) do
          {
            input: {
              listUuid: list.uuid,
              number: 1,
              name: '北海道旅行に行く'
            }
          }
        end

        it 'returns created item' do
          result = EnterpriseSchema.execute(query:, context:, variables:)
          expect(result.to_h.deep_symbolize_keys).to eq(
            {
              data: {
                upsertItem: {
                  item: {
                    number: 1,
                    name: '北海道旅行に行く',
                    doneAt: nil
                  }
                }
              }
            }
          )
        end

        it 'creates item' do
          EnterpriseSchema.execute(query:, context:, variables:)

          item = Item.last
          expect(item).to be_present
          expect(item.number).to eq 1
          expect(item.name).to eq '北海道旅行に行く'
        end
      end

      context 'when item exists' do
        let!(:item) { create(:item, list:, number: 1, name: '沖縄旅行に行く', done_at: nil) }

        let(:variables) do
          {
            input: {
              listUuid: list.uuid,
              number: 1,
              name: '北海道旅行に行く',
              doneAt: '2023-01-01T00:00:00Z'
            }
          }
        end

        it 'returns updated item' do
          result = EnterpriseSchema.execute(query:, context:, variables:)
          expect(result.to_h.deep_symbolize_keys).to eq(
            {
              data: {
                upsertItem: {
                  item: {
                    number: 1,
                    name: '北海道旅行に行く',
                    doneAt: '2023-01-01T09:00:00+09:00'
                  }
                }
              }
            }
          )
        end

        it 'updates item' do
          EnterpriseSchema.execute(query:, context:, variables:)

          item = Item.last
          expect(item).to be_present
          expect(item.number).to eq 1
          expect(item.name).to eq '北海道旅行に行く'
          expect(item.done_at).to be_present
        end
      end
    end

    context 'when list is not mine' do
      let!(:list) { create(:list) }
      let(:variables) do
        {
          input: {
            listUuid: list.uuid,
            number: 1,
            name: '北海道旅行に行く'
          }
        }
      end

      it 'returns error' do
        result = EnterpriseSchema.execute(query:, context:, variables:)
        expect(result.to_h.deep_symbolize_keys).to eq(
          {
            data: {
              upsertItem: nil
            },
            errors: [
              {
                locations: [column: 3, line: 2],
                message: 'List not found',
                path: ['upsertItem']
              }
            ]
          }
        )
      end
    end
  end
end
