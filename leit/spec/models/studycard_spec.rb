# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Studycard, type: :model do
  let(:studycard) { create(:studycard) }
  describe 'if answer is true' do
    it 'sends flashcard to next house' do
      prev_house = studycard.house
      studycard.level_up
      expect(studycard.house).to eql(prev_house + 1)
    end

    xit 'assigns the state of flashcard to 1' do
      studycard.level_up
      expect(studycard.state).to eql(1)
    end
  end

  describe 'if answer is false' do
    it 'sends flashcard to first house' do
      studycard.reset
      expect(studycard.house).to eql(0)
    end

    it 'adds up the reset count' do
      reset_count = studycard.reset_count
      studycard.reset
      expect(studycard.reset_count).to eql(reset_count + 1)
    end
  end
end
