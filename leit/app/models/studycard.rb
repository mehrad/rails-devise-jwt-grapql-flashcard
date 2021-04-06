# frozen_string_literal: true

class Studycard < ApplicationRecord
  belongs_to :flashcard

  delegate :question, to: :flashcard
  delegate :answer, to: :flashcard
  delegate :tag_list, to: :flashcard

  def level_up
    self.house = house.to_i + 1
    last_studied_at = Time.now
  end

  def level_up!
    level_up
    save!
  end

  def reset
    self.house = 0
    self.reset_count = reset_count.to_i + 1
    last_studied_at = Time.now
  end

  def reset!
    reset
    save!
  end

  def intervaled?(intervals)
    return true if house.to_i.zero? || last_studied_at.nil?
    return false if house >= intervals.size
    
    
    Time.now > last_studied_at + intervals[house].days
  end
end
