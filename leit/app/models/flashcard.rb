# frozen_string_literal: true

class Flashcard < ApplicationRecord
  acts_as_taggable_on :tags
  belongs_to :box
end
