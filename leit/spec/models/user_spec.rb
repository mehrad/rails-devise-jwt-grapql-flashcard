# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    it { is_expected.to have_many(:boxes).class_name('Box') }
  end

  describe 'callbacks' do
    it 'creates an auth token before saving if one does not exist' do
      # See: Devise initializer `config.http_authenticatable = true`
      user = described_class.new(attributes_for(:user))
      expect(user.authentication_token).to be_blank

      user.save

      expect(user.reload.authentication_token).not_to be_blank
    end
  end
end
