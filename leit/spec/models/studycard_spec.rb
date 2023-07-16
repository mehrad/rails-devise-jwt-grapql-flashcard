# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Studycard do
  let(:user) { create(:user_with_boxes_flashcards_studycards) }
  let(:flashcard) { user.boxes.first.flashcards.first }

  describe 'associations' do
    it { is_expected.to belong_to(:flashcard).class_name('Flashcard') }
    it { is_expected.to have_many(:study_stats).class_name('StudyStat') }
  end

  describe 'stats' do
    context 'when create' do
      subject { flashcard.active_study_card.study_stats.last.log }

      it { is_expected.to have_key('timestamp') }
      it { is_expected.to include('current_house' => 0) }
      it { is_expected.to include('prev_house' => -1) }
    end
  end
end
