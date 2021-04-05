# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :flashcard do
    answer { 'MyString' }
    question { Faker::ProgrammingLanguage.name }
    image_url { 'MyString' }
    tag_list { %w[Math React] }
    studycards { build_list :studycard, 3 }
  end
end
