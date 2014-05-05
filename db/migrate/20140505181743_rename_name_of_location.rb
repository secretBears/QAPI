class RenameNameOfLocation < ActiveRecord::Migration
  def change
    rename_column :places, :name, :city
  end
end
