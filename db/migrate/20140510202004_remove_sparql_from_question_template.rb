class RemoveSparqlFromQuestionTemplate < ActiveRecord::Migration
  def change
    change_table :question_templates do |t|
      t.references :query
    end

    remove_column :question_templates, :sparql
  end
end
