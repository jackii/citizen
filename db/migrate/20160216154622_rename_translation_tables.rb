class RenameTranslationTables < ActiveRecord::Migration
  def change
    rename_table :citizen_budget_model_multiplier_translations, :citizen_budget_model_policy_table_translations
    rename_table :citizen_budget_model_policy_translations, :citizen_budget_model_economic_measure_translations
    rename_column :citizen_budget_model_policy_table_translations, :citizen_budget_model_multiplier_id, :citizen_budget_model_policy_table_id
    rename_column :citizen_budget_model_economic_measure_translations, :citizen_budget_model_policy_id, :citizen_budget_model_economic_measure_id
    change_column :citizen_budget_model_policy_tables, :growth_forecast, :decimal
  end
end
