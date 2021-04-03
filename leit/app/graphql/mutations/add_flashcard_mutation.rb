# frozen_string_literal: true

module Mutations
  class AddFlashcardMutation < Mutations::BaseMutation
    graphql_name 'AddFlashcard'

    argument :box_id, Integer, required: true
    argument :question, String, required: true
    argument :answer, String, required: false
    argument :tag_list, [String], required: false

    field :flashcard, Types::FlashcardType, null: true

    def resolve(box_id:, question:, answer: nil, tag_list: nil)
      raise GraphQL::ExecutionError, 'You need to authenticate to perform this action' if context[:current_user].nil?

      user = context[:current_user]

      box = Box.find_by(id: box_id, user: user)

      raise GraphQL::ExecutionError, 'You do not have autherization to perform this action' if box.nil?

      flashcard = Flashcard.new(
        box_id: box_id,
        question: question,
        answer: answer,
        tag_list: tag_list
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
