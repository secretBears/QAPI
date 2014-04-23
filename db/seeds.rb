# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

(1..40).each do |q|
  question = Question.create!(question: "Frage #{q}")

  (1...4).each do |a|
    Answer.create!(question_id: question.id, answer: "#{q} answer #{a}")
  end
end
