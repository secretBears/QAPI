class AddPlaceRefToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :place, index: true
  end
end
