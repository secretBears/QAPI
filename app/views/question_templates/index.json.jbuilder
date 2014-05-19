json.array!(@question_templates) do |question_template|
  json.extract! question_template, :id
  json.url question_template_url(question_template, format: :json)
end
