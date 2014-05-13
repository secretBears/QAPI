class Query < ActiveRecord::Base
  has_one :question_template
  validates_presence_of :query_hash, :location_property, :answer_property
  serialize :query_hash, Hash

  before_save :parse_hash
  #after_find :stringify_hash

  def get(location)
    query = self[:query_hash].clone
    query[self[:location_property]] = location
    result = fire_query query

    result['answer'] = result[self[:answer_property]]
    result.delete(self[:answer_property])
    result
  end

  private
  def parse_hash
    self.query_hash = JSON.parse(self.query_hash)
  end

  def stringify_hash
    self.query_hash = JSON.unparse(self.query_hash)
  end

  def fire_query(query)
    result = FreebaseAPI.session.mqlread query
    fail Exceptions::QueryNotFound, 'No Results for query' + query.to_s if result.nil?
    result
  end
end
