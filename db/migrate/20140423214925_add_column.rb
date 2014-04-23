class AddColumn < ActiveRecord::Migration
  def change
    add_column :answers, :is_true, :boolean
  end
end
