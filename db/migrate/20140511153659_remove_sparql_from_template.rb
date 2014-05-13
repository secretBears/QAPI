class RemoveSparqlFromTemplate < ActiveRecord::Migration
  def change
    remove_column :question_templates, :sparql
  end
end
