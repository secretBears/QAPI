json.set! :id, @question.id
json.set! :question, @question.question
json.set! :place, @question.place['city']
json.set! :answers, @question.answers do |answer|
  json.set! :answer, answer.answer
  json.set! :is_true, answer.is_true
end

