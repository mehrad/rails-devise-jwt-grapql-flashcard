# frozen_string_literal: true

class FlashCardStudyQueryService
  STUDY_INTERVALS = [1, 2, 7, 15, 29].freeze

  def initialize(args = {})
    @args = args
  end

  def call
    limit = args[:limit] || 20
    offset = args[:offset] || 0
    box = args[:box]

    return [nil, false, 'Box must exists'] if box.nil?

    return [nil, false, 'Box must have flashcards'] if box.flashcards.nil?

    res = []

    box.flashcards.each do |flashcard|
      res << flashcard if flashcard.intervaled?(STUDY_INTERVALS)
    end

    [res, true, nil]
  end

  private

  attr_reader :args
end
