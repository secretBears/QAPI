class QueryHashValidator < ActiveModel::Validator
  def validate(record)
    parsed_query = JSON.parse record.query_hash
    unless parsed_query.class == Array
      record.errors[:query_hash] << "needs to be an array"
    end
  end
end
