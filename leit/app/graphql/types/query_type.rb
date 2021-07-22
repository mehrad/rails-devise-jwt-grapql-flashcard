# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :me, Types::UserType, null: true

    field :boxes,
          [Types::BoxType],
          null: false,
          description: 'Returns a list of boxes' do
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
    end

    field :flashcards,
          [Types::FlashcardType],
          null: false,
          description: 'Returns a list of flashcards' do
      argument :box_id, Integer, required: false
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
    end

    field :studycards,
          [Types::FlashcardType],
          null: false,
          description: 'Returns a list of stduycards' do
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
      argument :box_id, Integer, required: true
    end

    field :study_stats,
          [Types::StudyStatType],
          null: false,
          description: 'Returns a flash card stats' do
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
      argument :flashcard_id, Integer, required: true
    end

    def study_stats(flashcard_id:)
      Flashcard.find(flashcard_id).active_study_card.study_stats
    end

    def boxes(limit: 20, offset: 0)
      Box.boxes_for(me).limit(limit).offset(offset)
    end

    def studycards(box_id:, limit: 20, offset: 0)
      box = Box.boxes_for(me).where(id: box_id).first
      flashcards, success, errors = FlashCardStudyQueryService.new(box: box, limit: limit, offset: offset).call
      flashcards
    end

    def flashcards(limit: 20, offset: 0, box_id: nil)
      Flashcard.flashcards_for(me, box_id).limit(limit).offset(offset)
    end

    def me
      context[:current_user]
    end
  end
end
