class AddUnitValueUpToQuestion < ActiveRecord::Migration
  def change
    add_column :citizen_budget_model_questions, :unit_value_up, :float
    rename_column :citizen_budget_model_questions, :unit_value, :unit_value_down
  end

  def up
    CitizenBudgetModel::Question.all.each do |question|
      question.update_attribute(:unit_value_up, question.unit_value_down)
    end
  end
end
