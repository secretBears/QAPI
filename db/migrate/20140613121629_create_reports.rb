class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer, :user_id
      t.integer, :question_id
      t.string, :comment
      t.string :problem

      t.timestamps
    end
  end
end
