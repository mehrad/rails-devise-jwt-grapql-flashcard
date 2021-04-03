# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::UpdateFlashcardMutation do
  it 'updates in flashcards' do
    flashcard = create(:flashcard)
    box = create(:box)
    box.flashcards << flashcard
    box.save!
    box.reload

    variables = {
      'id' => flashcard.id.to_s,
      'question' => 'question?',
      'answer' => 'answer',
      'tag_list' => %w[b1 b2],
      'box_id' => box.id
    }

    context = {
      current_user: box.user
    }

    result = gql_query(query: mutation, variables: variables, context: context)
    result = result.to_h.deep_symbolize_keys.dig(:data, :updateFlashcard)

    flashcard.reload
    expect(result.dig(:flashcard, :question)).to eq(flashcard.question)
    expect(result.dig(:flashcard, :tags)).to match_array(flashcard.tag_list)
    expect(result[:success]).to eq(true)
    expect(result[:errors]).to be_blank
  end

  it 'raises not found error if there is no flashcard ' do
    box = create(:box)

    variables = {
      'id' => '1',
      'question' => 'question?',
      'answer' => 'answer',
      'tag_list' => %w[tag1 tag2],
      'box_id' => box.id
    }

    context = {
      current_user: box.user
    }

    result = gql_query(query: mutation, variables: variables, context: context)
    result = result.to_h.deep_symbolize_keys

    expect(result.dig(:errors, 0, :message)).to eq('Flashcard not found')
  end

  it 'raises authentication error without context' do
    flashcard = create(:flashcard)
    box = create(:box)

    variables = {
      'id' => flashcard.id.to_s,
      'question' => 'question?',
      'answer' => 'answer',
      'tag_list' => %w[tag1 tag2],
      'box_id' => box.id
    }

    context = {
      current_user: nil
    }
    result = gql_query(query: mutation, variables: variables, context: context)
    result = result.to_h.deep_symbolize_keys

    expect(result.dig(:errors, 0, :message)).to eq('You need to authenticate to perform this action')
  end

  it 'raises autherization error if flashcard does not belong to user' do
    flashcard = create(:flashcard)
    box = create(:box)

    variables = {
      'id' => flashcard.id.to_s,
      'question' => 'question?',
      'answer' => 'answer',
      'tag_list' => %w[b1 b2],
      'box_id' => box.id
    }

    context = {
      current_user: box.user
    }

    result = gql_query(query: mutation, variables: variables, context: context)
    result = result.to_h.deep_symbolize_keys

    expect(result.dig(:errors, 0, :message)).to eq('You do not have autherization to perform this action')
  end

  def mutation
    <<~GQL
      mutation UpdateFlashcard($box_id: Int!, $id: String!, $question: String!, $answer: String!, $tag_list: [String!]) {
      	updateFlashcard(input: { boxId: $box_id, id: $id, question: $question, answer: $answer , tagList: $tag_list}) {
      	flashcard {
      		id
      		question
      		answer
      		tags
      		box {
                        id
                        title
      		}
      	}
      	success
      	errors
      	}
      }
    GQL
  end
end
