# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'flashcards' do
    let!(:user) { create(:user_with_boxes_flashcards_studycards) }
    let!(:flashcards) { user.boxes.collect(&:flashcards).flatten! }
    let!(:admin) { create(:admin_with_boxes_flashcards_studycards) }
    let!(:admin_flashcards) { admin.boxes.collect(&:flashcards).flatten! }
    let!(:all_flashcards) { admin_flashcards + flashcards }

    context 'admin user' do
      subject(:result) do
        LeitSchema.execute(query, context: context).as_json
      end

      let(:query) do
        %(query {
          flashcards {
            id
          }
        })
      end

      let(:context) do
        {
          current_user: admin
        }
      end

      it 'returns all flashcards' do
        expect(result.dig('data', 'flashcards')).to match_array(
          all_flashcards.map { |flashcard| { 'id' => flashcard.id.to_s } }
        )
      end
    end

    context 'normal user' do
      subject(:result) do
        LeitSchema.execute(query, context: context).as_json
      end

      let(:query) do
        %(query {
          flashcards {
            id
          }
        })
      end

      let(:context) do
        {
          current_user: user
        }
      end

      it 'returns only users flashcards' do
        expect(result.dig('data', 'flashcards')).to match_array(
          flashcards.map { |flashcard| { 'id' => flashcard.id.to_s } }
        )
      end
    end

    context 'normal user box' do
      subject(:result) do
        LeitSchema.execute(query, context: context).as_json
      end

      let(:box) { user.boxes.first }

      let(:query) do
        %(query {
          flashcards(boxId:#{box.id}) {
            id
          }
        })
      end

      let(:context) do
        {
          current_user: user
        }
      end

      it 'returns only one box flashcards given box id' do
        expect(result.dig('data', 'flashcards')).to match_array(
          box.flashcards.map { |flashcard| { 'id' => flashcard.id.to_s } }
        )
      end
    end
  end

  describe 'studycards' do
    subject(:result) do
      LeitSchema.execute(query).as_json
    end

    let(:user) { create(:user) }
    let(:box) { create(:box, user: user) }
    let(:flashcard) { create(:flashcard, box: box) }
    let!(:studycards) { create_pair(:studycard, flashcard: flashcard) }

    let(:query) do
      %(query Studycard {
        studycards(boxId: 21) {
          id
          question
          answer
          house
          hint
          lastStudiedAt
        }
      })
    end

    xit 'returns all studycards' do
      expect(result.dig('data', 'studycards')).to match_array(
        studycards.map { |studycard| { 'hint' => studycard.hint } }
      )
    end
  end

  describe 'boxes' do
    let!(:user) { create(:user_with_boxes_flashcards_studycards) }
    let(:boxes) { user.boxes }
    let!(:admin) { create(:admin_with_boxes_flashcards_studycards) }
    let(:admin_boxes) { admin.boxes }
    let!(:all_boxes) { admin_boxes + boxes }

    let(:query) do
      %(query {
        boxes {
          title
        }
      })
    end

    context 'admin user' do
      subject(:result) do
        LeitSchema.execute(query, context: context).as_json
      end

      let(:context) do
        {
          current_user: admin
        }
      end

      it 'returns all boxes' do
        expect(result.dig('data', 'boxes')).to match_array(
          all_boxes.map { |box| { 'title' => box.title } }
        )
      end
    end

    context 'normal user' do
      subject(:result) do
        LeitSchema.execute(query, context: context).as_json
      end

      let(:context) do
        {
          current_user: user
        }
      end

      it 'returns only boxes' do
        expect(result.dig('data', 'boxes')).to match_array(
          boxes.first.user.boxes.map { |box| { 'title' => box.title } }
        )
      end
    end
  end
end
