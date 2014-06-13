
  json.question @questions.inspect
  json.answers @questions.answers do |answer|
    json.answer answer.answer
    json.isTrue answer.is_true
  end

