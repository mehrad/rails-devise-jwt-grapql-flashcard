# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Flashcard, type: :model do
  describe 'associations' do
    it { should belong_to(:box).class_name('Box') }
    it { should have_many(:studycards).class_name('Studycard') }
  end

  describe '#create' do
    let!(:user) { create(:user) }
    let!(:flashcard) { user.boxes.first.flashcards.first }

    it { expect(flashcard.studycards).not_to be_empty}
  end

  describe '#StudyLogic' do
    let!(:user) { create(:user) }
    let!(:flashcard) { user.boxes.first.flashcards.first }

    context 'if answer is true' do
      it { expect{ flashcard.level_up! }.to change{ flashcard.active_study_card.reload.house }.by(1) }
    end

    context 'if answer is false' do
      xit { expect{ flashcard.reset! }.to change{ flashcard.reload.active_study_card.reload.house}.to(0) }
      it { expect{ flashcard.reset! }.to change{ flashcard.reload.active_study_card.reload.reset_count }.by(1) }
    end
  end
end
