# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FlashCardStudyCommandService, type: :model do
  describe '#call' do
    let(:user) { create(:user) }

    context 'with correct variables' do
      let(:variables) do
        {
          box_id: user.boxes.first.id,
          question: 'question?',
          answer: 'answer',
          hint: 'hint',
          tag_list: %w[tag1 tag2]
        }
      end
      subject { FlashCardStudyCommandService.new(variables) }

      it 'creates flashcards and studycards, no errors with success true' do
        flashcard, success, errors = subject.call

        expect(flashcard).not_to be_nil
        expect(flashcard.hint).to eq(variables[:hint])
        expect(success).to be(true)
        expect(errors).to be_nil
      end
    end

    context 'with bad variables' do
      let(:variables) do
        {
          box_id: '',
          question: 'question',
          answer: 'answer',
          hint: 'hint',
          tag_list: %w[tag1 tag2]
        }
      end

      subject { FlashCardStudyCommandService.new(variables) }

      it 'returns errors and success false' do
        flashcard, success, errors = subject.call

        expect(flashcard).to be_nil
        expect(success).to be(false)
        expect(errors).to eq(['Box must exist'])
      end
    end
  end
end
