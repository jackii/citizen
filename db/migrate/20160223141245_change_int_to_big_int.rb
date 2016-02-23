class ChangeIntToBigInt < ActiveRecord::Migration
  def change

    change_column :citizen_budget_model_impact_variables, :prepopulated_result, :bigint
  end
end
