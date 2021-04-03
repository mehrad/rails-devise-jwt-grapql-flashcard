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
          description: 'Returns a list of boxes'

    field :flashcards,
          [Types::FlashcardType],
          null: false,
          description: 'Returns a list of flashcards'

    field :studycards,
          [Types::StudycardType],
          null: false,
          description: 'Returns a list of stduycards'

    def boxes
      Box.preload(:user)
    end

    def studycards
      Studycard.preload(:flashcard)
    end

    def flashcards
      Flashcard.preload(:box)
    end

    def me
      context[:current_user]
    end
  end
end
