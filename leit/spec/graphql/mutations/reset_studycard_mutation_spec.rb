# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::ResetStudycardMutation do
	it "reset a studycard" do
		user = create(:user)
		studycard = create(:studycard)

		variables = {
			"id" => studycard.id,
		}

		context = {
			current_user: user
		}

		result = gql_query(query: mutation, variables: variables, context: context)
		result = result.to_h.deep_symbolize_keys.dig(:data, :resetStudycard)
		studycard.reload

		expect(result.dig(:studycard, :house)).to eq(studycard.house)
		expect(result[:success]).to eq(true)
		expect(result[:errors]).to be_blank
	end

	def mutation
		<<~GQL
		mutation ResetStudycard($id: ID!) {
			resetStudycard(input: { id: $id}) {
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
