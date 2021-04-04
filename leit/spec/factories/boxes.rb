# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :box do
    title { Faker::ProgrammingLanguage.name }
    desc { Faker::ProgrammingLanguage.creator }
    user
  end
end
