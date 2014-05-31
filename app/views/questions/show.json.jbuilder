

json.question @question[:question]
json.answers @question[:answers] do |answer|
  json.answer answer[:answer]
  json.isTrue answer[:is_true]
end

