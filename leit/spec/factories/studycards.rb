# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :studycard do
    hint { 'MyString' }
    first_studied_at { '2021-03-17 22:47:52' }
    last_studied_at { '2021-03-17 22:47:52' }
    state { 0 }
    house { 0 }
    reset_count { 0 }
    visit_count { 0 }
    user
    flashcard
  end
end
