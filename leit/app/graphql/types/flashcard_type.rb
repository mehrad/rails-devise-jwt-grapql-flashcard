# frozen_string_literal: true

module Types
  class FlashcardType < Types::BaseObject
    field :id, ID, null: false
    field :answer, String, null: true
    field :question, String, null: true
    field :image_url, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :tags, [String], null: true
    field :box_id, Integer, null: true
    field :box, Types::BoxType, null: true

    def tags
      object.tag_list
    end
  end
end
