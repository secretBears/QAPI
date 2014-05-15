class Query < ActiveRecord::Base
  has_one :question_template
  validates_presence_of :query_hash, :location_property, :answer_property
  validates :query_hash, json: true
  after_find :parse_hash

  def get(location)
    query = self[:query_hash].clone
    query = JSON.parse(query) unless query.class == Hash

    query[self[:location_property]] = location

    result = fire_query query

    result['answer'] = result[self[:answer_property]]
    result.delete(self[:answer_property])
    result
  end

  private
  def parse_hash
    self.query_hash = JSON.parse(query_hash)
  end

  def fire_query(query)
    query = JSON.parse query unless query.class == Hash
    result = FreebaseAPI.session.mqlread query
    fail Exceptions::QueryNotFound, 'No Results for query' + query.to_s if result.nil?
    result
  end
end
