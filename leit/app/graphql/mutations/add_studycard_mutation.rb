# frozen_string_literal: true

module Mutations
  class AddStudycardMutation < Mutations::BaseMutation
    graphql_name 'AddStudycard'

    argument :flashcard_id, Integer, required: true

    field :studycard, Types::StudycardType, null: true

    def resolve(flashcard_id:)
      GraphQL::ExecutionError.new('You need to authenticate to perform this action') if context[:current_user].nil?
      user = context[:current_user]

      flashcard = Flashcard.find_by(id: flashcard_id)
      GraphQL::ExecutionError.new('Flashcard not found') if flashcard.nil?

      studycard = Studycard.new(
        flashcard_id: flashcard.id,
        user: user
      )

      success = studycard.save
      MutationResult.call(
        obj: { studycard: studycard },
        success: success,
        errors: studycard.errors.full_messages
      )
    end
  end
end
