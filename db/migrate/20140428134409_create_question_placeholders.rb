class CreateQuestionPlaceholders < ActiveRecord::Migration
  def change
    create_table :question_placeholders do |t|
      t.string :key, index: true
      t.string :value
      t.belongs_to :question_template

      t.timestamps
    end
  end
end
