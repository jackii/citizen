class AddDefaultFormulaToSensitivity < ActiveRecord::Migration
  def change
    add_column :citizen_budget_model_sensitivities, :default_formula, :text
    add_column :citizen_budget_model_sensitivities, :default_excel_formula, :text
  end
end
