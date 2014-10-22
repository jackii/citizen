class AddTotalRevenueToCitizenBudgetModelSimulator < ActiveRecord::Migration
  def change
    add_column :citizen_budget_model_simulators, :total_revenue, :integer
  end
end
