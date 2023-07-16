# frozen_string_literal: true

module Mutations
  class AddBoxMutation < Mutations::BaseMutation
    graphql_name 'AddBox'

    argument :desc, String, required: false
    argument :title, String, required: true

    field :box, Types::BoxType, null: true

    def resolve(title:, desc: nil)
      user = context[:current_user]

      raise GraphQL::ExecutionError, 'You need to authenticate to perform this action' if context[:current_user].nil?

      box = Box.new(
        user: user,
        title: title,
        desc: desc
      )

      success = box.save
      MutationResult.call(
        obj: { box: box },
        success: success,
        errors: box.errors.full_messages
      )
    end
  end
end
