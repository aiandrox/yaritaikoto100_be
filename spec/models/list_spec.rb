# frozen_string_literal: true

require 'rails_helper'

RSpec.describe List do
  describe 'create_default_value!' do
    subject(:create_default_value!) { described_class.create_default_value!(user, items:) }

    let(:user) { create(:user) }

    context 'when items is empty' do
      let(:items) { [] }

      it 'creates only list' do
        expect { create_default_value! }.to change(described_class, :count).by(1)
                                        .and not_change(Item, :count)
      end

      it 'creates list with default attributes' do
        create_default_value!
        list = described_class.last
        expect(list.title).to eq 'やりたいことリスト'
        expect(list.items.count).to eq 0
      end
    end

    context 'when items is present' do
      let(:items) { ['北海道旅行に行く'] }

      it 'creates list and items' do
        expect { create_default_value! }.to change(described_class, :count).by(1)
                                        .and change(Item, :count).by(1)
      end

      it 'creates list with default attributes' do
        create_default_value!
        list = described_class.last
        expect(list.title).to eq 'やりたいことリスト'
        expect(list.items.count).to eq 1
      end

      it 'creates items with value' do
        create_default_value!
        item = Item.last
        expect(item.number).to eq 1
        expect(item.name).to eq '北海道旅行に行く'
      end
    end

    context 'when items has empty value' do
      let(:items) { ['北海道旅行に行く', '', '', '沖縄旅行に行く'] }

      it 'creates list and present items' do
        expect { create_default_value! }.to change(described_class, :count).by(1)
                                        .and change(Item, :count).by(2)
      end

      it 'creates list with default attributes' do
        create_default_value!
        list = described_class.last
        expect(list.title).to eq 'やりたいことリスト'
        expect(list.items.count).to eq 2
      end

      it 'creates items with value' do
        create_default_value!
        item = Item.first
        expect(item.number).to eq 1
        expect(item.name).to eq '北海道旅行に行く'
      end

      it 'skip number for empty value' do
        create_default_value!
        item = Item.last
        expect(item.number).to eq 4
        expect(item.name).to eq '沖縄旅行に行く'
      end
    end
  end
end
