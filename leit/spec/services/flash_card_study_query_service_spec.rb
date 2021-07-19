# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FlashCardStudyQueryService, type: :model do
  describe '#call' do
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

      xit 'without offest it sets offset to 0 and limit 20' do
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
          studycard.update!(last_studied_at: Time.now)
          to_study_cards, success, errors = subject.call
          expect(to_study_cards).to be_empty
        end

        it 'shows after 1 or more days passed last study' do
          studycard.update!(last_studied_at: (Time.now - 1.days))
          studycard.reload
          to_study_cards, success, errors = subject.call
          expect(to_study_cards).to match_array([flashcard])
        end
      end

      describe '#first house' do
        before { studycard.update!(house: 1) }

        it 'does not show before second day passed last study' do
          studycard.update!(last_studied_at: (Time.now - 1.days))
          studycard.reload
          to_study_cards, success, errors = subject.call
          expect(to_study_cards).to be_empty
        end

        it 'shows after second day passed last study' do
          studycard.update!(last_studied_at: (Time.now - 3.days))
          studycard.reload
          to_study_cards, success, errors = subject.call
          expect(to_study_cards).to match_array([flashcard])
        end
      end

      describe '#second house' do
        before { studycard.update!(house: 2) }

        it 'does not show before 7th day passed last study' do
          studycard.update!(last_studied_at: (Time.now - 6.days))
          studycard.reload
          to_study_cards, success, errors = subject.call
          expect(to_study_cards).to be_empty
        end

        it 'shows after 7th day passed last study' do
          studycard.update!(last_studied_at: (Time.now - 8.days))
          studycard.reload
          to_study_cards, success, errors = subject.call
          expect(to_study_cards).to match_array([flashcard])
        end
      end

      describe '#third house' do
        before { studycard.update!(house: 3) }

        it 'does not show before 15th day passed last study' do
          studycard.update!(last_studied_at: (Time.now - 14.days))
          studycard.reload
          to_study_cards, success, errors = subject.call
          expect(to_study_cards).to be_empty
        end

        it 'shows after 15th day passed last study' do
          studycard.update!(last_studied_at: (Time.now - 16.days))
          studycard.reload
          to_study_cards, success, errors = subject.call
          expect(to_study_cards).to match_array([flashcard])
        end
      end

      describe '#forth house' do
        before { studycard.update!(house: 4) }

        it 'does not show before 29th day passed last study' do
          studycard.update!(last_studied_at: (Time.now - 28.days))
          studycard.reload
          to_study_cards, success, errors = subject.call
          expect(to_study_cards).to be_empty
        end

        it 'shows after 29th day passed last study' do
          studycard.update!(last_studied_at: (Time.now - 30.days))
          studycard.reload
          to_study_cards, success, errors = subject.call
          expect(to_study_cards).to match_array([flashcard])
        end

        it 'does not show learned one' do
          studycard.update!(house: 5)
          studycard.reload
          to_study_cards, success, errors = subject.call
          expect(to_study_cards).to be_empty
        end

        xit 'shows higher houses first' do
          studycard.update!(last_studied_at: (Time.now - 30.days))
          studycard.reload

          another_flashcard = create(:flashcard)
          another_studycard = create(:studycard, flashcard: another_flashcard)
          another_studycard.update!(house: 3, last_studied_at: (Time.now - 30.days))
          another_studycard.reload

          to_study_cards, success, errors = subject.call
          expect(to_study_cards.first.id).to eq(studycard.id)
        end
      end
    end

    xit 'returns studys cards order by house desc and last time studied desc' do
    end
  end
end
