require "rails_helper"

RSpec.describe Types::QueryType do
  describe "flashcards" do
    let!(:flashcards) { create_pair(:flashcard) }

    let(:query) do
      %(query {
        flashcards {
          question
        }
      })
    end

    subject(:result) do
      LeitSchema.execute(query).as_json
    end

    it "returns all flashcards" do
      expect(result.dig("data", "flashcards")).to match_array(
        flashcards.map { |flashcard| { "question" => flashcard.question } }
      )
    end
  end
end