# frozen_string_literal: true

FactoryBot.define do
  factory :box do
    title { 'MyString' }
    desc { 'MyText' }
    user
  end
end
