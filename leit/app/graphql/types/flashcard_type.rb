# frozen_string_literal: true

module Types
  class FlashcardType < Types::BaseObject
    field :answer, String, null: true
    field :box, Types::BoxType, null: true
    field :box_id, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :hint, String, null: true
    field :house, Integer, null: true
    field :id, ID, null: false
    field :image_url, String, null: true
    field :last_studied_at, GraphQL::Types::ISO8601DateTime, null: true
    field :question, String, null: true
    field :tags, [String], null: true, method: :tag_list
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    delegate :last_studied_at, to: :object

    delegate :hint, to: :object

    delegate :house, to: :object
  end
end
