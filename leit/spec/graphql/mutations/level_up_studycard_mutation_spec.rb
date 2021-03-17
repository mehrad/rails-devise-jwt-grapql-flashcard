# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::LevelUpStudycardMutation do
	it "level up a studycard" do
		user = create(:user)
		studycard = create(:studycard)

		variables = {
			"id" => studycard.id,
		}

		context = {
			current_user: user
		}

		result = gql_query(query: mutation, variables: variables, context: context)
		result = result.to_h.deep_symbolize_keys.dig(:data, :levelUpStudycard)
		studycard.reload

		expect(result.dig(:studycard, :house)).to eq(studycard.house)
		expect(result[:success]).to eq(true)
		expect(result[:errors]).to be_blank
	end

	def mutation
		<<~GQL
		mutation LevelUpStudycard($id: ID!) {
			levelUpStudycard(input: { id: $id}) {
			studycard {
				id
				house
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
