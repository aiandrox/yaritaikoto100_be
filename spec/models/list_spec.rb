# frozen_string_literal: true

require 'rails_helper'

RSpec.describe List do
  describe 'create_with_items!' do
    subject(:create_with_items!) { described_class.create_with_items!(user) }

    let(:user) { create(:user) }

    it 'creates list and items' do
      expect { create_with_items! }.to change { List.count }.by(1)
                                   .and change { Item.count }.by(100)
    end
  end
end
