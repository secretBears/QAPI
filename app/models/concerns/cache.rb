class Cache
  def self.clear_all
    Cache.clear_all_questions
    Cache.clear_all_places
  end

  def self.clear_all_questions
    Question.destroy_all
  end

  def self.clear_questions_from_template(template_id)
    questions = Question.where question_template_id: template_id
    questions.destroy_all
  end

  def self.clear_all_places
    Place.destroy_all
  end

  def self.clear_old_questions
    ttl       = QAPI::Application.config.question_ttl
    questions = Question.where('updated_at < :ttl', ttl: ttl.ago)
    puts questions
  end
end
