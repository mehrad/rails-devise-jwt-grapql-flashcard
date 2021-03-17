module Types
  class StudycardType < Types::BaseObject
    field :id, ID, null: false
    field :hint, String, null: true
    field :house, Integer, null: false
    field :state, Integer, null: false
    field :reset_count, Integer, null: false
    field :visit_count, Integer, null: false
    field :first_studied_at, GraphQL::Types::ISO8601DateTime, null: false
    field :last_studied_at, GraphQL::Types::ISO8601DateTime, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user, Types::UserType, null: false
    field :flashcard, Types::FlashcardType, null: false

  end
end