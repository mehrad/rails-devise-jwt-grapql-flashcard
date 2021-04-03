# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AddFlashcardMutation do
  it 'adds in flashcard' do
    box = create(:box)

    variables = {
      'box_id' => box.id,
      'question' => 'question?',
      'answer' => 'answer',
      'tag_list' => %w[tag1 tag2]
    }

    context = {
      current_user: box.user
    }

    result = gql_query(query: mutation, variables: variables, context: context)
    result = result.to_h.deep_symbolize_keys.dig(:data, :addFlashcard)

    expect(result.dig(:flashcard, :question)).to eq(variables['question'])
    expect(result.dig(:flashcard, :tags)).to eq(variables['tag_list'])
    expect(result[:success]).to eq(true)
    expect(result[:errors]).to be_blank
  end

  it 'raises authentication error without context' do
    box = create(:box)

    variables = {
      'box_id' => box.id,
      'question' => 'question?',
      'answer' => 'answer',
      'tag_list' => %w[tag1 tag2]
    }

    context = {
      current_user: nil
    }

    flashcard = create(:flashcard, **variables.symbolize_keys)

    result = gql_query(query: mutation, variables: variables, context: context)

    result = result.to_h.deep_symbolize_keys
    expect(result.dig(:errors, 0, :message)).to eq('You need to authenticate to perform this action')
    expect(result[:addFlashcard]).to be_blank
  end

  def mutation
    <<~GQL
      mutation AddFlashcard($box_id: Int!, $question: String!, $answer: String!, $tag_list: [String!]) {
      	addFlashcard(input: { boxId: $box_id, question: $question, answer: $answer , tagList: $tag_list}) {
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
