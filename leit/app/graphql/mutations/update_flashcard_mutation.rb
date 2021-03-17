module Mutations
	class UpdateFlashcardMutation < Mutations::BaseMutation
		graphql_name "UpdateFlashcard"

		argument :id, String, required: true
		argument :question, String, required: true
		argument :answer, String, required: false
		argument :box_list, [String], required: false
		
		field :flashcard, Types::FlashcardType, null: true

		def resolve(id:, question:, answer: nil, box_list: nil)
		GraphQL::ExecutionError.new("You need to authenticate to perform this action") if context[:current_user].nil?
		user = context[:current_user]
		
		flashcard = Flashcard.find_by(id: id)
		GraphQL::ExecutionError.new("Flashcard not found") if flashcard.nil?
		

		success = flashcard&.update(
			question: question,
			answer: answer,
			box_list: box_list,
			user: user
		) || false

		MutationResult.call(
			obj: { flashcard: flashcard },
			success: success,
			errors: flashcard&.errors&.full_messages
		)
		end
	end
end