# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require_relative '../../test/helpers/fakeweb_helper'

Place.get 47.8094888, 13.0550007 # Salzburg
Place.get 48.208174, 16.373819   # Wien
Place.get 48.306940, 14.285830   # Linz
Place.get(-33.867487, 151.206990) # Sydney

(1..10).each do |i|
  QuestionPlaceholder.create!(
    key: '?name',
    value: (LoremIpsum.lorem_ipsum words: 1),
    question_template_id: i
  )
end

(1..20).each do |q|
  question = Question.create!(
      question: "Frage #{q}",
      place_id: (q % Place.count) + 1,
      question_template: QuestionTemplate.first
  )

  true_idx = rand(1..4)
  (1..4).each do |a|
    Answer.create!(
        question_id: question.id,
        answer: "#{q} answer #{a}",
        is_true: (true_idx == a)
    )
  end
end

User.create!(email: 'user@email.tld', password: '12345678')
User.create!(email: 'user2@email.tld', password: '12345678', admin: 'true')
api_key = ApiKey.find 1
api_key[:token] = '4e31ed23c464a5abe3d7af57ee23ec72'
api_key.save!
