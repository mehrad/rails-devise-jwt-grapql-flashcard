# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :box do
    title { Faker::ProgrammingLanguage.name }
    desc { Faker::ProgrammingLanguage.creator }

    factory :box_with_flashcards_studycards do
      flashcards { build_list(:flashcard_with_studycards, 3) }
    end
  end
end
