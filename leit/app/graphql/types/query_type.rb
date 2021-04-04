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
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
    end

    field :studycards,
          [Types::StudycardType],
          null: false,
          description: 'Returns a list of stduycards' do
            argument :limit, Integer, required: false
            argument :offset, Integer, required: false
          end

    def boxes(limit: 20, offset: 0)
      Box.preload(:user).limit(limit).offset(offset)
    end

    def studycards(limit: 20, offset: 0)
      Studycard.preload(:flashcard).limit(limit).offset(offset)
    end

    def flashcards(limit: 20, offset: 0)
      Flashcard.preload(:box).limit(limit).offset(offset)
    end

    def me
      context[:current_user]
    end
  end
end
