class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.text :query_hash
      t.text :location_property
      t.text :answer_property
    end
  end
end
