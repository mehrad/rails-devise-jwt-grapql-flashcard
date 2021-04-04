# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'flashcards' do
    let!(:flashcards) { create_pair(:flashcard) }

    let(:query) do
      %(query {
        flashcards {
          question
        }
      })
    end

    subject(:result) do
      LeitSchema.execute(query).as_json
    end

    it 'returns all flashcards' do
      expect(result.dig('data', 'flashcards')).to match_array(
        flashcards.map { |flashcard| { 'question' => flashcard.question } }
      )
    end
  end

  describe 'studycards' do
    let!(:studycards) { create_pair(:studycard) }

    let(:query) do
      %(query {
        studycards {
          hint
        }
      })
    end

    subject(:result) do
      LeitSchema.execute(query).as_json
    end

    it 'returns all studycards' do
      expect(result.dig('data', 'studycards')).to match_array(
        studycards.map { |studycard| { 'hint' => studycard.hint } }
      )
    end
  end

  describe 'boxes' do
    let!(:boxes) { create_pair(:box) }

    let(:query) do
      %(query {
        boxes {
          title
        }
      })
    end

    context 'admin user' do
      let(:admin) do
        create(:admin)
      end

      let(:context) do
        {
          current_user: admin
        }
      end

      subject(:result) do
        LeitSchema.execute(query, context: context).as_json
      end

      it 'returns all boxes' do
        expect(result.dig('data', 'boxes')).to match_array(
          boxes.map { |box| { 'title' => box.title } }
        )
      end
    end

    context 'normal user' do
      let(:context) do
        {
          current_user: boxes.first.user
        }
      end

      subject(:result) do
        LeitSchema.execute(query, context: context).as_json
      end

      it 'returns only boxes' do
        expect(result.dig('data', 'boxes')).to match_array(
          boxes.first.user.boxes.map { |box| { 'title' => box.title } }
        )
      end
    end
  end
end
