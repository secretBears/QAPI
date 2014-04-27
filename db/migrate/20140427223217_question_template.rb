class QuestionTemplate < ActiveRecord::Migration
  def change
    add_column :question_templates, :question, :string
    add_column :question_templates, :sparql, :string

    add_reference :question_templates, :question, index: true
  end
end
