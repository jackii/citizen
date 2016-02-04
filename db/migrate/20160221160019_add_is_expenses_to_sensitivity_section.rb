class AddIsExpensesToSensitivitySection < ActiveRecord::Migration
  def change
    add_column :citizen_budget_model_sensitivity_sections, :is_expenses, :boolean, default: false
  end
end
