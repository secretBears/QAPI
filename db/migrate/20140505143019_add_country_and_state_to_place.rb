class AddCountryAndStateToPlace < ActiveRecord::Migration
  def change
    add_column :places, :state, :string
    add_column :places, :country, :string
  end
end
