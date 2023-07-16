# frozen_string_literal: true

# Card that user add to study later
# it belongs to boxes and has many study cards
# study cards are not visible to end user and
# only being used to be able to save to proccess
# of learning a card.
class Flashcard < ApplicationRecord
  acts_as_taggable_on :tags
  belongs_to :box
  has_many :studycards, dependent: :destroy

  ACTIVE_STUDY_DELEGATES = %w[hint state reset_count house reset! level_up!].freeze

  def self.flashcards_for(user, box_id)
    return all if user&.admin?

    return where(box: [user&.boxes]) if box_id.nil?

    where(box_id: box_id)
  end

  delegate :last_studied_at, to: :active_study_card

  delegate :hint, to: :active_study_card

  delegate :state, to: :active_study_card

  delegate :reset_count, to: :active_study_card

  delegate :house, to: :active_study_card

  delegate :reset!, to: :active_study_card

  delegate :level_up!, to: :active_study_card

  delegate :intervaled?, to: :active_study_card

  def active_study_card
    studycards.last
  end

  def self.ransackable_attributes(auth_object = nil)
    super + %w[answer question]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[box studycards]
  end
end
