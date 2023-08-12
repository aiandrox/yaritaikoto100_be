# frozen_string_literal: true

require 'rails_helper'

RSpec.describe List do
  describe 'create_default_value!' do
    subject(:create_default_value!) { described_class.create_default_value!(user) }

    let(:user) { create(:user) }

    it 'creates list' do
      expect { create_default_value! }.to change { List.count }.by(1)
    end

    it 'creates list with default attributes' do
      create_default_value!
      list = List.last
      expect(list.title).to eq('やりたいことリスト')
      expect(list.items.count).to eq(0)
    end
  end
end
