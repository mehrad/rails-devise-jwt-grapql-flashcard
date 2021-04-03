# frozen_string_literal: true

module Types
  class BoxType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: true
    field :desc, String, null: true
    field :user_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user, Types::UserType, null: true
  end
end
