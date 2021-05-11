# frozen_string_literal: true

class Box < ApplicationRecord
  belongs_to :user
  has_many :flashcards, dependent: :destroy

  def self.boxes_for(user)
    return all if user&.admin?

    where(user: user)
  end
end
