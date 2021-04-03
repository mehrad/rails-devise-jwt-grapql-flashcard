# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AddStudycardMutation do
  it 'adds in studycard' do
    user = create(:user)
    flashcard = create(:flashcard)

    variables = {
      'flashcard_id' => flashcard.id
    }

    context = {
      current_user: user
    }

    result = gql_query(query: mutation, variables: variables, context: context)
    result = result.to_h.deep_symbolize_keys.dig(:data, :addStudycard)

    expect(result.dig(:studycard, :flashcard, :question)).to eq(flashcard.question)
    expect(result[:success]).to eq(true)
    expect(result[:errors]).to be_blank
  end

  def mutation
    <<~GQL
      mutation AddStudycard($flashcard_id: Int!) {
      	addStudycard(input: { flashcardId: $flashcard_id}) {
      	studycard {
      		id
      		flashcard {
      			id
      			question
      		}
      		user {
      		id
      		email
      		}
      	}
      	success
      	errors
      	}
      }
    GQL
  end
end
