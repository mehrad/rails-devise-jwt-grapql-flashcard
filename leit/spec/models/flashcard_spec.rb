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
    end

    context 'when answer is false' do
      before do
        flashcard.active_study_card.house = 1
        flashcard.save!
      end

      it { expect { flashcard.reset! }.to change { flashcard.active_study_card.house }.to(0) }
      it { expect { flashcard.reset! }.to change { flashcard.active_study_card.reset_count }.by(1) }
    end
  end
end
