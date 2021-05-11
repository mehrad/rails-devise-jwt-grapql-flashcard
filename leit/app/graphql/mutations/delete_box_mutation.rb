# frozen_string_literal: true

module Mutations
  class DeleteBoxMutation < Mutations::BaseMutation
    graphql_name 'DeleteBox'

    argument :id, ID, required: true

    field :box, Types::BoxType, null: true

    def resolve(id:)
      user = context[:current_user]

      raise GraphQL::ExecutionError, 'You need to authenticate to perform this action' if context[:current_user].nil?

      box = Box.where(
        id: id,
        user: user
      ).first

      raise GraphQL::ExecutionError, 'You need to authenticate to perform this action' if box.nil?

      success = box&.destroy
      MutationResult.call(
        success: success,
        errors: box.errors.full_messages
      )
    end
  end
end
