json.array!(@question_placeholders) do |question_placeholder|
  json.extract! question_placeholder, :id, :key, :value, :question_id
  json.url question_placeholder_url(question_placeholder, format: :json)
end
