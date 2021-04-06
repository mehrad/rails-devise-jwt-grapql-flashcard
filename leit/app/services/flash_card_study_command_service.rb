# frozen_string_literal: true

class FlashCardStudyCommandService
  def initialize(**args)
    @args = args
  end

  def call
    flashcard = Flashcard.new(
      box_id: args[:box_id],
      question: args[:question],
      answer: args[:answer],
      tag_list: args[:tag_list]
    )

    return error_message(flashcard.errors.full_messages) unless flashcard.save

    studycard = Studycard.new(
      flashcard: flashcard,
      hint: args[:hint]
    )

    unless studycard.save
      flashcard.delete!
      return error_message(flashcard.errors.full_messages) unless flashcard.save
    end

    [
      flashcard,
      true,
      nil
    ]
  end

  private

  attr_reader :args

  def error_message(msg)
    [
      nil,
      false,
      msg
    ]
  end
end
