# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone { Faker::PhoneNumber.cell_phone }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    boxes { build_list :box, 3}

    factory :admin do
      after(:create) { |user| user.add_role(:admin) }
    end
  end
end
