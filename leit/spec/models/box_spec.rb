# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Box, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should have_many(:flashcards).class_name('Flashcard') }
  end
end
