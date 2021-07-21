class StudyStat < ApplicationRecord
  belongs_to :studycard

  store_accessor :log, :timestamp, :prev_house, :current_house
end
