
if @question[:error].nil?
  json.set! :id, @question.id
  json.set! :question, @question.question
  json.set! :answers, @question.answers
else
  json.array! @question
end

