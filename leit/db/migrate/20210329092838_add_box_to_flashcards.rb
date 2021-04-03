# frozen_string_literal: true

class AddBoxToFlashcards < ActiveRecord::Migration[6.1]
  def change
    add_reference :flashcards, :box, index: true, null: true
    add_foreign_key :flashcards, :boxes
  end
end
