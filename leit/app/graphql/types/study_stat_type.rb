module Types
  class StudyStatType < Types::BaseObject
    field :id, ID, null: false
    field :log, GraphQL::Types::JSON, null: false
  end
end
