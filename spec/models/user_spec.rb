# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe '.create_anonymous!' do
    subject(:create_anonymous!) { described_class.create_anonymous! }

    it 'creates user' do
      expect { create_anonymous! }.to change(described_class, :count).by(1)
    end

    it 'returns user' do
      expect(create_anonymous!).to be_a described_class
    end

    it 'returns user with uuid' do
      user = create_anonymous!
      expect(BCrypt::Password.new(user.user_digest) == user.uuid).to be true
    end
  end

  describe '#authenticated?' do
    subject(:authenticated?) { user.authenticated?('uuid') }

    context 'when uuid is correct' do
      let(:user) { create(:user, user_digest: BCrypt::Password.create('uuid', cost: 1)) }

      it { is_expected.to be true }
    end

    context 'when uuid is incorrect' do
      let(:user) { create(:user, user_digest: BCrypt::Password.create('not uuid', cost: 1)) }

      it { is_expected.to be false }
    end
  end
end
