class AddFormulaToImpact < ActiveRecord::Migration
  def change
    add_column :citizen_budget_model_impacts, :year_1_formula, :text
    add_column :citizen_budget_model_impacts, :year_1_excel_formula, :text
    add_column :citizen_budget_model_impacts, :year_2_formula, :text
    add_column :citizen_budget_model_impacts, :year_2_excel_formula, :text
    add_column :citizen_budget_model_impacts, :year_5_formula, :text
    add_column :citizen_budget_model_impacts, :year_5_excel_formula, :text
    add_column :citizen_budget_model_impacts, :is_public, :boolean, default: true
  end
end
