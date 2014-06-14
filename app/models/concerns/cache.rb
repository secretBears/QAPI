class Cache
  def self.clear_all
    fail 'not implemented'
  end

  def self.clear_all_questions
    Question.destroy_all
    true
  rescue
    false
  end

  def self.clear_questions_from_template(template_id)
    questions = Question.where question_template_id: template_id
    questions.destroy_all
    true
  rescue
    false
  end

  def self.clear_all_places
    Place.destroy_all
    true
  rescue
    false
  end
end