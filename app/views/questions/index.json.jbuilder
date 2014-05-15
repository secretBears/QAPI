dskjfldsjfla
json.array!(@questions) do |question|
  json.extract! question, :id, :question
  json.url question_path(question, format: :json)
end
