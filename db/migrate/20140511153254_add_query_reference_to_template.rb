class AddQueryReferenceToTemplate < ActiveRecord::Migration
  def change
    add_reference :question_templates, :query, index: true
  end
end
