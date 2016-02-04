class AddSimulatorToMultiplier < ActiveRecord::Migration
  def change
    add_column :citizen_budget_model_multipliers, :simulator_id, :integer
  end
end
