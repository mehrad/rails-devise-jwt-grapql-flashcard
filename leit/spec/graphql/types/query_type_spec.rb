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

  describe 'study stats' do
    subject(:result) do
      LeitSchema.execute(query, context: context).as_json
    end

    let(:user) { create(:user_with_boxes_flashcards_studycards) }
    let(:study_stats) { user.boxes.first.flashcards.first.active_study_card.study_stats }

    let(:context) do
      {
        current_user: user
      }
    end

    let(:query) do
      %(query Studycard {
        studyStats(flashcardId: #{user.boxes.first.flashcards.first.id}) {
          log
        }
      })
    end

    it 'returns flashcard stats' do
      expect(result.dig('data', 'studyStats')).to match_array(
        study_stats.map { |stat| { 'log' => stat.log } }
      )
    end
  end
end
