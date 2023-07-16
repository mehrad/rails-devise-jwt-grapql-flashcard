# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :add_box, mutation: Mutations::AddBoxMutation
    field :add_flashcard, mutation: Mutations::AddFlashcardMutation
    field :delete_box, mutation: Mutations::DeleteBoxMutation
    field :level_up_card, mutation: Mutations::LevelUpCardMutation
    field :register_user, mutation: Mutations::RegisterUserMutation
    field :reset_card, mutation: Mutations::ResetCardMutation
    field :sign_in, mutation: Mutations::SignInMutation
    field :sign_out, mutation: Mutations::SignOutMutation
    field :update_flashcard, mutation: Mutations::UpdateFlashcardMutation
  end
end
