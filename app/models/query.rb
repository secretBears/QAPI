class Query < ActiveRecord::Base
  belongs_to :question
  validates_presence_of :query_hash, :location_property, :answer_property
  serialize :query_hash, Hash

  def get(location)
    query = self[:query_hash].clone
    query[self[:location_property]] = location
    result = fire_query query

    result['answer'] = result[self[:answer_property]]
    result.delete(self[:answer_property])
    result
  end

  private
  def fire_query(query)
    result = FreebaseAPI.session.mqlread query
    fail Exceptions::QueryNotFound, 'No Results for query' if result.nil?
    result
  end
end
