class Studycard < ApplicationRecord
  belongs_to :user
  belongs_to :flashcard

  delegate :question, to: :flashcard
  delegate :answer, to: :flashcard
  delegate :box_list, to: :flashcard

  def level_up
   self.house = self.house.to_i + 1
  end

  def reset
    self.house = 0 
    self.reset_count = self.reset_count.to_i + 1
  end
end
