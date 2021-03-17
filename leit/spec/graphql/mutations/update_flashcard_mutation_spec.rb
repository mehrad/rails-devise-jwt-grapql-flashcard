# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateFlashcardMutation do
	it "updates in flashcards" do
		user = create(:user)
        flashcard = create(:flashcard)

		variables = {
            "id" => "#{flashcard.id}",
			"question" => "question?",
			"answer" => "answer",
			"box_list" => ["b1", "b2"],
		}

		context = {
			current_user: user
		}

		result = gql_query(query: mutation, variables: variables, context: context)
		result = result.to_h.deep_symbolize_keys.dig(:data, :updateFlashcard)

        flashcard.reload
		expect(result.dig(:flashcard, :question)).to eq(flashcard.question)
		expect(result.dig(:flashcard, :boxes)).to match_array(flashcard.box_list)
		expect(result[:success]).to eq(true)
		expect(result[:errors]).to be_blank
	end

    it "raises not found error if there is no flashcard " do
		user = create(:user)

		variables = {
            "id" => "1",
			"question" => "question?",
			"answer" => "answer",
			"box_list" => ["box1", "box2"],
		}

		context = {
			current_user: user
		}

		result = gql_query(query: mutation, variables: variables, context: context)
		result = result.to_h.deep_symbolize_keys.dig(:data, :updateFlashcard)

		expect(result.dig(:data, :updateFlashcard)).to be_blank
	end

	it "raises authentication error without context" do
        flashcard = create(:flashcard)
		
        variables = {
            "id" => "#{flashcard.id}",
			"question" => "question?",
			"answer" => "answer",
			"box_list" => ["box1", "box2"],
		}

		result = gql_query(query: mutation, variables: variables)
		result = result.to_h.deep_symbolize_keys.dig(:data, :updateFlashcard)


		expect(result.dig(:errors, 0)).to eq("User must exist")
		expect(result.dig(:data, :updateFlashcard)).to be_blank
	end

	def mutation
		<<~GQL
		mutation UpdateFlashcard($id: String!, $question: String!, $answer: String!, $box_list: [String!]) {
			updateFlashcard(input: { id: $id, question: $question, answer: $answer , boxList: $box_list}) {
			flashcard {
				id
				question
				answer
				boxes
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
