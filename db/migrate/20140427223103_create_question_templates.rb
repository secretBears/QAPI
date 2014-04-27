class CreateQuestionTemplates < ActiveRecord::Migration
  def change
    create_table :question_templates do |t|
      t.belongs_to :question
      t.timestamps
    end
  end
end
