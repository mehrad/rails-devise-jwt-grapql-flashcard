module Mutations
	class LevelUpStudycardMutation < Mutations::BaseMutation
		graphql_name "LevelUpStudycard"

		argument :id, ID, required: true
		
		field :studycard, Types::StudycardType, null: true

		def resolve(id:)
		GraphQL::ExecutionError.new("You need to authenticate to perform this action") if context[:current_user].nil?
		user = context[:current_user]
		
		studycard = Studycard.find_by(id: id)
		GraphQL::ExecutionError.new("studycard not found") if studycard.nil?

		studycard.level_up

		success = studycard.save
		MutationResult.call(
			obj: { studycard: studycard },
			success: success,
			errors: studycard.errors.full_messages
		)
		end
	end
end