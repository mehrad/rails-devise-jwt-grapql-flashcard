# frozen_string_literal: true

class Box < ApplicationRecord
  belongs_to :user
  has_many :flashcards
end
