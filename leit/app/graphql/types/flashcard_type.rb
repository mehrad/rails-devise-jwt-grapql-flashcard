module Types
  class FlashcardType < Types::BaseObject
    field :id, ID, null: false
    field :answer, String, null: true
    field :question, String, null: true
    field :image_url, String, null: true
    field :user_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :boxes, [String], null: true
    field :user, Types::UserType, null: false

    def boxes
      object.box_list
    end
  end
end
