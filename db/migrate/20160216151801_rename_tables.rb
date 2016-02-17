class RenameTables < ActiveRecord::Migration
  def change
    rename_table :citizen_budget_model_multipliers, :citizen_budget_model_policy_tables
    rename_table :citizen_budget_model_policies, :citizen_budget_model_economic_measures
    rename_column :citizen_budget_model_policy_sections, :multiplier_id, :policy_table_id
    change_column :citizen_budget_model_economic_measures, :year_1_value, :decimal
    change_column :citizen_budget_model_economic_measures, :year_2_value, :decimal
  end
end

