# frozen_string_literal: true

class RemoveUserFromFlashcards < ActiveRecord::Migration[6.1]
  def change
    change_table :flashcards do |t|
      t.remove_references :user
    end
  end
end
