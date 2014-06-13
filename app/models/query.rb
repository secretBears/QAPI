class Query < ActiveRecord::Base
  has_one :question_template
  validates :query_hash, :location_property, :answer_property, presence: true
  validates :query_hash, json: true

  def get(location)
    query = self[:query_hash].clone
    query = JSON.parse(query) unless query.class == Hash

    query = Misc.replace_in_json query, self[:location_property], location
    result = fire_query query

    answer = Misc.find_in_json result, self[:answer_property]
    answer = answer.join ', '
    result['answer'] = answer

    result.delete(self[:answer_property])
    result
  end

  def self.create_from_prams!(params)
    # TODO: i dont know why Query.create! is not working but self.create!
    self.create!(
        query_hash:  params['mql'],
        answer_property: params['answer_property'],
        location_property: params['location_property']
    )
  end

  private
  def fire_query(query)
    result = FreebaseAPI.session.mqlread query
    fail Exceptions::QueryNotFound, 'No Results for query' + query.to_s if result.nil?
    result
  end
end
