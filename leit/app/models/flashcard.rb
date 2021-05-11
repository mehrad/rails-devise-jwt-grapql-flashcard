# frozen_string_literal: true

class Flashcard < ApplicationRecord
  acts_as_taggable_on :tags
  belongs_to :box
  has_many :studycards, dependent: :destroy

  ACTIVE_STUDY_DELEGATES = %w[hint state reset_count house reset! level_up!].freeze

  # ACTIVE_STUDY_DELEGATES.each do |method_name|
  #   eval <<-DEFINE_METHOD
  #     def #{method_name}
  #       active_study_card.(#{method_name})
  #     end
  #   DEFINE_METHOD
  # end

  def self.flashcards_for(user, box_id)
    return all if user&.admin?

    return where(box: [user&.boxes]) if box_id.nil?

    where(box_id: box_id)
  end

  def last_studied_at
    active_study_card.last_studied_at
  end

  def hint
    active_study_card.hint
  end

  def state
    active_study_card.state
  end

  def reset_count
    active_study_card.reset_count
  end

  def house
    active_study_card.house
  end

  def reset!
    active_study_card.reset!
  end

  def level_up!
    active_study_card.level_up!
  end

  def intervaled?(intervals)
    active_study_card.intervaled?(intervals)
  end

  def active_study_card
    studycards.last
  end
end
