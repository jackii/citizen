class RenameEmploymentCoefficient < ActiveRecord::Migration
  def change
    rename_column :citizen_budget_model_policy_tables, :employment_coeffiecient, :employment_coefficient
  end
end
