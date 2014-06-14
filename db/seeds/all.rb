profession_template_hash = <<-HERE_DOC
  {
    "type": "/people/person",
    "place_of_birth~=": "Linz",
    "limit": 1,
    "name": null,
    "profession": [{
         "name": [],
         "limit": 1
     }]
  }
HERE_DOC

QuestionTemplate.create!(
    question: "What was the profession of ?name?",
    query: Query.create(
        query_hash: profession_template_hash,
        location_property: 'place_of_birth~=',
        answer_property: '$.profession[0].name'
    )
)

birthday_template_hash = <<-HERE_DOC
  {
    "type": "/people/person",
    "place_of_birth~=": "Linz",
    "date_of_birth": null,
    "limit": 1,
    "name": null,
    "profession": [{
         "name": "Politician"
     }]
  }
HERE_DOC

QuestionTemplate.create!(
    question: "When was the birthday of ?name?",
    query: Query.create(
        query_hash: birthday_template_hash,
        location_property: 'place_of_birth~=',
        answer_property: '$.date_of_birth'
    )
)

music_template_hash = <<-HERE_DOC
  {
    "type": "/music/artist",
    "origin": "Linz",
    "limit": 1,
    "name": null,
    "genre":  [{
         "name": null,
          "limit": 1
    }]
  }
HERE_DOC

QuestionTemplate.create!(
    question: "Which genre is the music of ?name attributed to?",
    query: Query.create(
        query_hash: music_template_hash,
        location_property: 'origin',
        answer_property: '$.genre[*].name'
    )
)
