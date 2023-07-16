# frozen_string_literal: true

FactoryBot.define do
  factory :study_stat do
    log { { timestamp: Time.now.to_i, prev_house: -1, current_house: 0 } }
  end
end
