# frozen_string_literal: true

module Mutations
  class ResetCardMutation < Mutations::BaseMutation
    graphql_name 'ResetCard'

    argument :id, ID, required: true

    field :flashcard, Types::FlashcardType, null: true

    def resolve(id:)
      if context[:current_user].nil?
        raise GraphQL::ExecutionError.new,
              'You need to authenticate to perform this action'
      end

      context[:current_user]

      flashcard = Flashcard.find_by(id: id)
      raise GraphQL::ExecutionError, 'flashcard not found' if flashcard.nil?

      flashcard.reset!

      success = flashcard.save
      MutationResult.call(
        obj: { flashcard: flashcard },
        success: success,
        errors: flashcard.errors.full_messages
      )
    end
  end
end
