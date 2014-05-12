class RenameSparqlToQueryOfQuestionTemplates < ActiveRecord::Migration
  def change
    rename_column :question_templates, :sparql, :query
  end
end
