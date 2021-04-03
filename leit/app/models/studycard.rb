# frozen_string_literal: true

class Studycard < ApplicationRecord
  belongs_to :user
  belongs_to :flashcard

  delegate :question, to: :flashcard
  delegate :answer, to: :flashcard
  delegate :tag_list, to: :flashcard

  def level_up
    self.house = house.to_i + 1
  end

  def reset
    self.house = 0
    self.reset_count = reset_count.to_i + 1
  end
end
