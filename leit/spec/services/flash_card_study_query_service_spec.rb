# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FlashCardStudyQueryService, type: :model do
  describe '#call' do
    subject { described_class.new(
      limit: 20,
      offset: 0,
      box: user_box
    ) }
    let(:user) { create(:user_with_boxes_flashcards_studycards) }
    let(:user_box) { user.boxes.first }

    context 'with right arguments' do
      it 'returns last availables study cards of a box properly' do
        subject = described_class.new(
          limit: 20,
          offset: 0,
          box: user_box
        )

        to_study_cards, success, errors = subject.call

        expect(to_study_cards).to match_array(user_box.flashcards)
        expect(success).to be true
        expect(errors).to be_nil
      end

      context 'without box_id' do
        it 'returns errors' do
          subject = described_class.new
          to_study_cards, success, errors = subject.call

          expect(to_study_cards).to be_nil
          expect(success).to be false
          expect(errors).to eq('Box must exists')
        end
      end
    end

    describe '#Interval logics' do
      subject { described_class.new(variables) }

      let(:variables) do
        {
          limit: 1,
          offset: 0,
          box: box
        }
      end

      let(:user) { create(:user) }
      let(:box) { create(:box, user: user) }
      let(:flashcard) { create(:flashcard, box: box) }
      let(:studycard) { create(:studycard, flashcard: flashcard) }

      describe '#zero house' do
        before { studycard.update!(house: 0) }

        it 'does not shows at the same time as last study' do
          studycard.update!(last_studied_at: Time.zone.now)
          to_study_cards, = subject.call
          expect(to_study_cards).to be_empty
        end

        it 'shows after 1 or more days passed last study' do
          studycard.update!(last_studied_at: 1.day.ago)
          studycard.reload
          to_study_cards, = subject.call
          expect(to_study_cards).to contain_exactly(flashcard)
        end
      end

      describe '#first house' do
        before { studycard.update!(house: 1) }

        it 'does not show before second day passed last study' do
          studycard.update!(last_studied_at: 1.day.ago)
          studycard.reload
          to_study_cards, = subject.call
          expect(to_study_cards).to be_empty
        end

        it 'shows after second day passed last study' do
          studycard.update!(last_studied_at: 3.days.ago)
          studycard.reload
          to_study_cards, = subject.call
          expect(to_study_cards).to contain_exactly(flashcard)
        end
      end

      describe '#second house' do
        before { studycard.update!(house: 2) }

        it 'does not show before 7th day passed last study' do
          studycard.update!(last_studied_at: 6.days.ago)
          studycard.reload
          to_study_cards, = subject.call
          expect(to_study_cards).to be_empty
        end

        it 'shows after 7th day passed last study' do
          studycard.update!(last_studied_at: 8.days.ago)
          studycard.reload
          to_study_cards, = subject.call
          expect(to_study_cards).to contain_exactly(flashcard)
        end
      end

      describe '#third house' do
        before { studycard.update!(house: 3) }

        it 'does not show before 15th day passed last study' do
          studycard.update!(last_studied_at: 14.days.ago)
          studycard.reload
          to_study_cards, = subject.call
          expect(to_study_cards).to be_empty
        end

        it 'shows after 15th day passed last study' do
          studycard.update!(last_studied_at: 16.days.ago)
          studycard.reload
          to_study_cards, = subject.call
          expect(to_study_cards).to contain_exactly(flashcard)
        end
      end

      describe '#forth house' do
        before { studycard.update!(house: 4) }

        it 'does not show before 29th day passed last study' do
          studycard.update!(last_studied_at: 28.days.ago)
          studycard.reload
          to_study_cards, = subject.call
          expect(to_study_cards).to be_empty
        end

        it 'shows after 29th day passed last study' do
          studycard.update!(last_studied_at: 30.days.ago)
          studycard.reload
          to_study_cards, = subject.call
          expect(to_study_cards).to contain_exactly(flashcard)
        end

        it 'does not show learned one' do
          studycard.update!(house: 5)
          studycard.reload
          to_study_cards, = subject.call
          expect(to_study_cards).to be_empty
        end
      end
    end
  end
end
