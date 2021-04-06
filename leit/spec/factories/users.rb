# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone { Faker::PhoneNumber.cell_phone }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    factory :user_with_boxes_flashcards_studycards do
      boxes { build_list :box_with_flashcards_studycards, 3 }
    end

    factory :admin_with_boxes_flashcards_studycards do
      boxes { build_list :box_with_flashcards_studycards, 3 }
      after(:create) { |user| user.add_role(:admin) }
    end
  end
end
