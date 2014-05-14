class AddRequestsToApiKey < ActiveRecord::Migration
  def change
    add_column :api_keys, :requests, :integer
  end
end
