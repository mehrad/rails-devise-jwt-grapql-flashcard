class Flashcard < ApplicationRecord
  acts_as_taggable_on :boxes
  belongs_to :user
end
