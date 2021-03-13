FactoryBot.define do
  factory :flashcard do
    answer { "MyString" }
    question { "MyText" }
    image_url { "MyString" }
    user { nil }
  end
end
