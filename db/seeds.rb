# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Place.geolocate_from_latlong  47.8094888, 13.0550007 # Salzburg
Place.geolocate_from_latlong  48.208174, 16.373819   # Wien
Place.geolocate_from_latlong  48.306940, 14.285830   # Linz

(1..10).each do |i|
  question_template_q = LoremIpsum.lorem_ipsum(words: 15).split(' ')
  idx = Random.rand(15)
  question_template_q[idx] = '?1'
  p = question_template_q.join(' ')

  QuestionTemplate.create!(question: p)

  QuestionPlaceholder.create!(
    key: '?1',
    value: (LoremIpsum.lorem_ipsum words: 1),
    question_template_id: i
  )
end

(1..20).each do |q|
  question = Question.create!(question: "Frage #{q}", place_id: (q % Place.count) + 1)

  true_idx = rand(1..4)
  (1..4).each do |a|
    Answer.create!(question_id: question.id, answer: "#{q} answer #{a}", is_true: (true_idx == a))
  end
end

User.create!(email: 'test@email.tld', password: '12345678')
