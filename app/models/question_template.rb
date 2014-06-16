class QuestionTemplate < ActiveRecord::Base
  has_many :questions
  has_many :question_placeholders
  belongs_to :query

  validates :question,  presence: true

  scope :find_by_query, ->(query) {where(query: query)}

  accepts_nested_attributes_for :query

  def self.random(limit = 1)
    QuestionTemplate.order('random()').limit(limit)
  end

  def self.create_from_params!(params, query)
    # TODO: i dont know why QuestionTemplate.create! is not working but self.create!
    self.create!(
        question: params['template_property'],
        query: query
    )
  end
end
