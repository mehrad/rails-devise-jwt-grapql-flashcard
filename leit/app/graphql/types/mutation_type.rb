# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :sign_in, mutation: Mutations::SignInMutation
    field :sign_out, mutation: Mutations::SignOutMutation
    field :register_user, mutation: Mutations::RegisterUserMutation
    field :add_flashcard, mutation: Mutations::AddFlashcardMutation
    field :update_flashcard, mutation: Mutations::UpdateFlashcardMutation
    field :level_up_card, mutation: Mutations::LevelUpCardMutation
    field :reset_card, mutation: Mutations::ResetCardMutation
    field :add_box, mutation: Mutations::AddBoxMutation
    field :delete_box, mutation: Mutations::DeleteBoxMutation
  end
end
