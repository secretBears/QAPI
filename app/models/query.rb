class QueryHashValidator < ActiveModel::Validator
  def validate(record)
    parsed_query = JSON.parse record.query_hash
    unless parsed_query.class == Array
      record.errors[:query_hash] << "needs to be an array"
    end
  end
end

# TODO: merge with question template
class Query < ActiveRecord::Base

  has_one :question_template
  validates :query_hash, :location_property, :answer_property, presence: true
  validates :query_hash, json: true
  validates_with QueryHashValidator

  def results(location)
    query = self[:query_hash].clone
    query = JSON.parse(query) unless query.class == Hash

    query = Misc.replace_in_json query, self[:location_property], location
    result = fire_query query

    answer = Misc.find_in_json result, self[:answer_property]
    answer = answer.join ', '

    {
      result: result,
      answer: answer
    }
  end

  def self.create_from_params!(params)
    # TODO: i dont know why Query.create! is not working but self.create!
    self.create!(
        query_hash:  params['mql'],
        answer_property: params['answer_property'],
        location_property: params['location_property']
    )
  end

  alias_method :get, :results

  private
  def fire_query(query)
    result = FreebaseAPI.session.mqlread query
    fail Exceptions::QueryNotFound, 'No Results for query' + query.to_s if result.nil?
    result
  end

end
