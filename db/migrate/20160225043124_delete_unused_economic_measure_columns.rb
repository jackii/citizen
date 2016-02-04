class DeleteUnusedEconomicMeasureColumns < ActiveRecord::Migration
  def change
    remove_column :citizen_budget_model_economic_measures, :default_value
    remove_column :citizen_budget_model_economic_measures, :minimum
    remove_column :citizen_budget_model_economic_measures, :maximum
    remove_column :citizen_budget_model_economic_measures, :step
  end
end
