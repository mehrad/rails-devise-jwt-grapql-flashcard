# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Studycard, type: :model do
  let(:flashcard) { create(:flashcard_with_studycards) }

  describe 'associations' do
    it { is_expected.to belong_to(:flashcard).class_name('Flashcard') }
  end
end
