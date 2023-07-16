# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Box do
  describe 'associations' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to have_many(:flashcards).class_name('Flashcard') }
  end
end
