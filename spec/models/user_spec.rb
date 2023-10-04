# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe '#update_access_token!' do
    subject(:update_access_token!) { user.update_access_token! }

    before do
      freeze_time
    end

    let(:user) { create(:user, access_token: nil) }

    it 'update access_token' do
      update_access_token!

      user.reload
      expect(user.access_token).to be_present
      payload = JWT.decode(user.access_token, ENV.fetch('ACCESS_TOKEN_SECRET_KEY')).first
      expect(payload).to eq({
        'sub' => user.id,
        'exp' => 1.week.since.end_of_day.to_i,
        'iat' => Time.current.to_i
      })
    end
  end
end
