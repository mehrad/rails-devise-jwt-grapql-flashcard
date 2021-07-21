# frozen_string_literal: true

# Study card model, for each time a flash card being studied
class Studycard < ApplicationRecord
  belongs_to :flashcard
  has_many :study_stats, dependent: :destroy

  after_initialize :initialize_defaults, if: :new_record?

  delegate :question, to: :flashcard
  delegate :answer, to: :flashcard
  delegate :tag_list, to: :flashcard

  def level_up
    stat = StudyStat.new(log: { timestamp: Time.now.to_i, prev_house: house, current_house: house.to_i + 1 })
    self.house = house.to_i + 1
    self.last_studied_at = Time.now
    study_stats << stat
    puts "\n"
    p study_stats.last
    puts '---'
    p stat
  end

  def level_up!
    level_up
    save!
  end

  def reset
    stat = StudyStat.new(log: { timestamp: Time.now.to_i, prev_house: house, current_house: 0 })
    self.house = 0
    self.reset_count = reset_count.to_i + 1
    self.last_studied_at = Time.now
    study_stats << stat
  end

  def reset!
    reset
    save!
  end

  def initialize_defaults
    self.last_studied_at ||= Time.now
  end

  def intervaled?(intervals)
    return false if house.to_i >= intervals.size

    self.last_studied_at ||= Time.now

    Time.now >= self.last_studied_at + intervals[house.to_i].days
  end
end
