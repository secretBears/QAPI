# TODO: merge with question template
class Query < ActiveRecord::Base

  has_one :question_template
  validates :query_hash, :location_property, :answer_property, presence: true
  validates :query_hash, json: true
  validates_with QueryHashValidator

  def results_for(location)
    query = self[:query_hash].clone
    query = JSON.parse(query) unless query.class == Hash

    query = Misc.replace_in_json query, self[:location_property], location
    results = fire_query query

    results.map do |result|
      answer = Misc.find_in_json result, self[:answer_property]
      answer = answer.join ', '

      {
        result: result,
        answer: answer
      }
    end
  end
  alias_method :results, :results_for
  alias_method :get, :results_for

  def self.create_from_params!(params)
    # TODO: i dont know why Query.create! is not working but self.create!
    self.create!(
        query_hash:  params['mql'],
        answer_property: params['answer_property'],
        location_property: params['location_property']
    )
  end

  private
  def fire_query(query)
    result = FreebaseAPI.session.mqlread Array.wrap(query)
    fail Exceptions::QueryNotFound, 'No Results for query' + query.to_s if result.nil?
    result
  end
end
