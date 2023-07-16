# frozen_string_literal: true

module Mutations
  class UpdateFlashcardMutation < Mutations::BaseMutation
    graphql_name 'UpdateFlashcard'

    argument :answer, String, required: false
    argument :box_id, Integer, required: true
    argument :id, String, required: true
    argument :question, String, required: true
    argument :tag_list, [String], required: false

    field :flashcard, Types::FlashcardType, null: true

    def resolve(id:, question:, box_id:, answer: nil, tag_list: nil)
      raise GraphQL::ExecutionError, 'You need to authenticate to perform this action' if context[:current_user].nil?

      user = context[:current_user]

      flashcard = Flashcard.find_by(id: id)
      raise GraphQL::ExecutionError, 'Flashcard not found' if flashcard.nil?

      box = Box.find_by(id: box_id, user: user)

      if box.nil? || box.flashcards.exclude?(flashcard)
        raise GraphQL::ExecutionError,
              'You do not have autherization to perform this action'
      end

      success = flashcard&.update(
        box: box,
        question: question,
        answer: answer,
        tag_list: tag_list
      ) || false

      MutationResult.call(
        obj: { flashcard: flashcard },
        success: success,
        errors: flashcard&.errors&.full_messages
      )
    end
  end
end
