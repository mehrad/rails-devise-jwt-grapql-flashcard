# frozen_string_literal: true

module Types
  class StudycardType < Types::BaseObject
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :first_studied_at, GraphQL::Types::ISO8601DateTime, null: false
    field :flashcard, Types::FlashcardType, null: false
    field :flashcard_id, Integer, null: false
    field :hint, String, null: true
    field :house, Integer, null: false
    field :id, ID, null: false
    field :last_studied_at, GraphQL::Types::ISO8601DateTime, null: false
    field :reset_count, Integer, null: false
    field :state, Integer, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user, Types::UserType, null: false
    field :user_id, Integer, null: false
    field :visit_count, Integer, null: false
  end
end
