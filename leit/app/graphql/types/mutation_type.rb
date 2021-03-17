module Types
  class MutationType < Types::BaseObject
    field :sign_in, mutation: Mutations::SignInMutation
    field :sign_out, mutation: Mutations::SignOutMutation
    field :register_user, mutation: Mutations::RegisterUserMutation
    field :add_flashcard, mutation: Mutations::AddFlashcardMutation
    field :update_flashcard, mutation: Mutations::UpdateFlashcardMutation
    field :add_studycard, mutation: Mutations::AddStudycardMutation
  end
end
