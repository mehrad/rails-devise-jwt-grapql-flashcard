# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

masoud = User.find_by(email: "maosud@gmail.com")
if masoud.nil?
    masoud = User.create!(
        email: "maosud@gmail.com",
        first_name: "Masoud",
        last_name: "Valizadeh",
        phone: '09123123123231',
        password: '123123123'
    )
end

mahrad = User.find_by(email: "mahrad@gmail.com")
if mahrad.nil?
    mahrad = User.create!(
    email: "mahrad@gmail.com",
    first_name: "Mahrad",
    last_name: "Ataeefard",
    phone: '0912314444',
    password: '123123123'
    )
end
  
  Flashcard.create!(
    [
      {
        question: "What is Earth?",
        answer: "Cult book by Ray Bradbury",
        user: mahrad,
        image_url: "https://upload.wikimedia.org/wikipedia/en/4/45/The-Martian-Chronicles.jpg",
        box_list: ["French", "React"]
      },
      {
        question: "What are The Martians?",
        answer: "Novel by Andy Weir about an astronaut stranded on Mars trying to survive",
        user: mahrad,
        image_url: "https://upload.wikimedia.org/wikipedia/en/c/c3/The_Martian_2014.jpg",
        box_list: ["French", "React"]
      },
      {
        question: "What is Doom?",
        answer: "A group of Marines is sent to the red planet via an ancient " \
                     "Martian portal called the Ark to deal with an outbreak of a mutagenic virus",
        user: masoud,
        image_url: "https://upload.wikimedia.org/wikipedia/en/5/57/Doom_cover_art.jpg",
        box_list: ["Mathematics", "Linux"]
      },
      {
        question: "Why Mars Attacks?!",
        answer: "Earth is invaded by Martians with unbeatable weapons and a cruel sense of humor",
        user: masoud,
        image_url: "https://upload.wikimedia.org/wikipedia/en/b/bd/Mars_attacks_ver1.jpg",
        box_list: ["Mathematics", "Linux"]
      }
    ]
  )
