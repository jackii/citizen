class AddActiveToCitizenBudgetModelSimulator < ActiveRecord::Migration
  def change
    add_column :citizen_budget_model_simulators, :active, :boolean, default: false
  end
end
