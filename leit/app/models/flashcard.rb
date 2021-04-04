# frozen_string_literal: true

class Flashcard < ApplicationRecord
  acts_as_taggable_on :tags
  belongs_to :box
  has_one :studycard

  def self.flashcards_for(user, box)
    return all if user.admin?

    where(box: box)
  end
end
