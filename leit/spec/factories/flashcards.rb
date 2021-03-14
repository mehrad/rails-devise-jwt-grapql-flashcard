FactoryBot.define do
  factory :flashcard do
    answer { "MyString" }
    question { "MyText" }
    image_url { "MyString" }
    box_list { ["Math", "React"]}
    user
  end
end
