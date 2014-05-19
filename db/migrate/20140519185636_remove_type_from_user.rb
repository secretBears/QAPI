class RemoveTypeFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :type
    add_column :users, :admin, :boolean
  end
end
