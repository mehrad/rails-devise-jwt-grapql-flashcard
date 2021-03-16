module Mutations
	class AddFlashcardMutation < Mutations::BaseMutation
		graphql_name "AddFlashcard"

		argument :question, String, required: true
		argument :answer, String, required: false
		argument :box_list, [String], required: false
		
		field :flashcard, Types::FlashcardType, null: true

		def resolve(question:, answer: nil, box_list: nil)
		GraphQL::ExecutionError.new("You need to authenticate to perform this action") if context[:current_user].nil?

		user = context[:current_user]

		flashcard = Flashcard.new(
			question: question,
			answer: answer,
			box_list: box_list,
			user: user
		)

		success = flashcard.save
		MutationResult.call(
			obj: { flashcard: flashcard },
			success: success,
			errors: flashcard.errors.full_messages
		)
		end
	end
end