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

  def self.ransackable_attributes(_auth_object = nil)
    # Define the attributes you want to make searchable by Ransack
    %w[flashcards_id user_id title desc]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[flashcards user]
  end
end
