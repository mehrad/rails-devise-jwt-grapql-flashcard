# frozen_string_literal: true

# Boxes are the way that flashcards
# being categorized in leitenrz  system
# Each box  contains some flashcards.
# it belongs to user.
class Box < ApplicationRecord
  belongs_to :user
  has_many :flashcards, dependent: :destroy

  def self.boxes_for(user)
    return all if user&.admin?

    where(user: user)
  end
end
