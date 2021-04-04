# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Flashcard, type: :model do
  describe 'associations' do
    it { should belong_to(:box).class_name('Box') }
    it { should have_one(:studycard).class_name('Studycard') }
  end
end
