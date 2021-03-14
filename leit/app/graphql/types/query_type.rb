module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    
    field :me, Types::UserType, null: true 
 
    field :flashcards,
          [Types::FlashcardType],
          null: false,
          description: "Returns a list of flashcards"
    def flashcards
      Flashcard.preload(:user)
    end

    def me
      context[:current_user]
    end
  end
end