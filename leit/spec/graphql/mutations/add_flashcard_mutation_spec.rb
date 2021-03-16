# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::AddFlashcardMutation do
	it "adds in flashcard" do
		user = create(:user)

		variables = {
			"question" => "question?",
			"answer" => "answer",
			"box_list" => ["box1", "box2"],
		}

		context = {
			current_user: user
		}

		result = gql_query(query: mutation, variables: variables, context: context)
		result = result.to_h.deep_symbolize_keys.dig(:data, :addFlashcard)

		expect(result.dig(:flashcard, :question)).to eq(variables["question"])
		expect(result.dig(:flashcard, :boxes)).to eq(variables["boxes"])
		expect(result[:success]).to eq(true)
		expect(result[:errors]).to be_blank
	end

	it "raises authentication error without context" do
		variables = {
			"question" => "question?",
			"answer" => "answer",
			"box_list" => ["box1", "box2"],
		}
		flashcard = create(:flashcard, **variables.symbolize_keys)

		result = gql_query(query: mutation, variables: variables)
		result = result.to_h.deep_symbolize_keys.dig(:data, :addFlashcard)


		expect(result.dig(:errors, 0)).to eq("User must exist")
		expect(result.dig(:data, :addFlashcard)).to be_blank
	end

	def mutation
		<<~GQL
		mutation AddFlashcard($question: String!, $answer: String!, $box_list: [String!]) {
			addFlashcard(input: { question: $question, answer: $answer , boxList: $box_list}) {
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
