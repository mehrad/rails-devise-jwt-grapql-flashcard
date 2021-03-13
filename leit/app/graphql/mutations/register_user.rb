module Mutations
    class RegisterUser < Mutations::BaseMutation
      graphql_name "RegisterUser"
  
      argument :phone, String, required: true
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true
  
      field :user, Types::UserType, null: false
  
      def resolve(args)
        user = User.create!(args)
        context[:current_user] = user
        MutationResult.call(
          obj: { user: user },
          success: user.persisted?,
          errors: user.errors
        )
      rescue ActiveRecord::RecordInvalid => invalid
        GraphQL::ExecutionError.new(
          "Invalid Attributes for #{invalid.record.class.name}: " \
          "#{invalid.record.errors.full_messages.join(', ')}"
        )
      end
    end
  end