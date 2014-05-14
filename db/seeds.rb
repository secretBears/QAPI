# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Place.get  47.8094888, 13.0550007 # Salzburg
Place.get  48.208174, 16.373819   # Wien
Place.get  48.306940, 14.285830   # Linz

query_hash = '{
    "type": "/people/person",
    "place_of_birth~=": "Linz",
    "limit": 1,
    "name": null,
    "profession": [{
                         "name": []
                     }]
}'

location_property = "place_of_birth~="
answer_property   = "profession"

(1..10).each do |i|
  query = Query.create!(
      query_hash: query_hash,
      location_property: location_property,
      answer_property: answer_property
  )

  question_template_q = LoremIpsum.lorem_ipsum(words: 15).split(' ')
  idx = Random.rand(15)
  question_template_q[idx] = '?name'
  p = question_template_q.join(' ')

  QuestionTemplate.create!(
      question: p,
      query: query
  )

  QuestionPlaceholder.create!(
    key: '?name',
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

User.create!(email: 'user@email.tld', password: '12345678')
Admin.create!(email: 'admin@email.tld', password: '12345678')
