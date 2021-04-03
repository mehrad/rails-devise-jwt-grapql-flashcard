# frozen_string_literal: true

module Mutations
  class SignOutMutation < Mutations::BaseMutation
    graphql_name 'SignOut'

    field :user, Types::UserType, null: false

    def resolve
      user = context[:current_user]
      GraphQL::ExecutionError.new('User not signed in') unless user.present?

      success = user.reset_authentication_token!

      MutationResult.call(
        obj: { user: user },
        success: success,
        errors: user.errors
      )
    end
  end
end
