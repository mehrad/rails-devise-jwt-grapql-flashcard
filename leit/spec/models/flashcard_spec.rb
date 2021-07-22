# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Flashcard, type: :model do
  let(:user) { create(:user_with_boxes_flashcards_studycards) }
  let(:flashcard) { user.boxes.first.flashcards.first }

  describe 'associations' do
    it { is_expected.to belong_to(:box).class_name('Box') }
    it { is_expected.to have_many(:studycards).class_name('Studycard') }
  end

  describe '#create' do
    it { expect(flashcard.studycards).not_to be_empty }
  end

  describe '#StudyLogic' do
    context 'when answer is true' do
      it { expect { flashcard.level_up! }.to change { flashcard.active_study_card.reload.house }.by(1) }
      it { expect { flashcard.level_up! }.to change { flashcard.active_study_card.study_stats.count }.by(1) }

      it {
        prev_house = flashcard.house
        flashcard.level_up!
        expect(flashcard.active_study_card.study_stats.reload.last.log['prev_house']).to eq(prev_house)
      }

      it {
        flashcard.level_up!
        current_house = flashcard.reload.house
        expect(flashcard.active_study_card.study_stats.reload.last.log['current_house']).to eq(current_house)
      }
    end
  end

  context 'when answer is false' do
    before do
      flashcard.active_study_card.house = 1
      flashcard.save!
    end

    it { expect { flashcard.reset! }.to change { flashcard.active_study_card.house }.to(0) }
    it { expect { flashcard.reset! }.to change { flashcard.active_study_card.reset_count }.by(1) }
    it { expect { flashcard.reset! }.to change { flashcard.active_study_card.study_stats.count }.by(1) }

    it {
      prev_house = flashcard.house
      flashcard.reset!
      expect(flashcard.active_study_card.study_stats.reload.last.log['prev_house']).to eq(prev_house)
    }

    it {
      flashcard.level_up!
      current_house = flashcard.reload.house
      expect(flashcard.active_study_card.study_stats.reload.last.log['current_house']).to eq(current_house)
    }
  end
end
