# frozen_string_literal: true

FactoryBot.define do
  factory :flashcard do
    answer { 'MyString' }
    question { 'MyText' }
    image_url { 'MyString' }
    tag_list { %w[Math React] }
    box
  end
end
