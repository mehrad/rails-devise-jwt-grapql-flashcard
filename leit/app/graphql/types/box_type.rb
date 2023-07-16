# frozen_string_literal: true

module Types
  class BoxType < Types::BaseObject
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :desc, String, null: true
    field :flashcards, [Types::FlashcardType], null: true
    field :id, ID, null: false
    field :title, String, null: true
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user, Types::UserType, null: true
    field :user_id, Integer, null: false
  end
end
