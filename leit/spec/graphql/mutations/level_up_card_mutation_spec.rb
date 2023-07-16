# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::LevelUpCardMutation do
  it 'level up a flashcard' do
    user = create(:user_with_boxes_flashcards_studycards)
    flashcard = user.boxes.first.flashcards.first

    variables = {
      'id' => flashcard.id
    }

    context = {
      current_user: user
    }

    result = gql_query(query: mutation, variables: variables, context: context)
    result = result.to_h.deep_symbolize_keys.dig(:data, :levelUpCard)
    flashcard.reload

    expect(result.dig(:flashcard, :house)).to eq(flashcard.house)
    expect(result[:success]).to be(true)
    expect(result[:errors]).to be_blank
  end

  def mutation
    <<~GQL
      mutation LevelUpCard($id: ID!) {
      	levelUpCard(input: { id: $id}) {
      	flashcard {
      		id
      		house
        }
      	success
      	errors
      	}
      }
    GQL
  end
end
