# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'flashcards' do
    let!(:user) { create(:user) }
    let!(:flashcards) { user.boxes.collect(&:flashcards).flatten! }
    let!(:admin) { create(:admin) }
    let!(:admin_flashcards) { admin.boxes.collect(&:flashcards).flatten! }
    let!(:all_flashcards) { admin_flashcards + flashcards }

    context 'admin user' do
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

      subject(:result) do
        LeitSchema.execute(query, context: context).as_json
      end

      it 'returns all flashcards' do
        expect(result.dig('data', 'flashcards')).to match_array(
          all_flashcards.map { |flashcard| { 'id' => flashcard.id.to_s } }
        )
      end
    end

    context 'normal user' do
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

      subject(:result) do
        LeitSchema.execute(query, context: context).as_json
      end

      it 'returns only flashcards' do
        expect(result.dig('data', 'flashcards')).to match_array(
          flashcards.map { |flashcard| { 'id' => flashcard.id.to_s } }
        )
      end
    end

    context 'normal user box' do
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

      subject(:result) do
        LeitSchema.execute(query, context: context).as_json
      end

      it 'returns only one box flashcards given box id' do
        expect(result.dig('data', 'flashcards')).to match_array(
          box.flashcards.map { |flashcard| { 'id' => flashcard.id.to_s } }
        )
      end
    end
  end

  describe 'studycards' do
    let(:user) { create(:user) }
    let(:flashcards) { user.boxes.first.flashcards }

    let(:query) do
      %(query {
        studycards(box_id: 1, offset:1, limit:2) {
          hint
        }
      })
    end

    subject(:result) do
      LeitSchema.execute(query).as_json
    end

    xit 'returns all studycards' do
      expect(result.dig('data', 'studycards')).to match_array(
        studycards.last(2).map { |studycard| { 'hint' => studycard.hint } }
      )
    end
  end

  describe 'boxes' do
    let!(:user) { create(:user) }
    let(:boxes) { user.boxes }
    let!(:admin) { create(:admin) }
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
          all_boxes.map { |box| { 'title' => box.title } }
        )
      end
    end

    context 'normal user' do
      let(:context) do
        {
          current_user: user
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
