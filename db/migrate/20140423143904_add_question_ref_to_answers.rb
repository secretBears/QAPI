class AddQuestionRefToAnswers < ActiveRecord::Migration
  def change
    remove_column :answers, :question_id
    add_reference :answers, :question, index: true
  end
end
