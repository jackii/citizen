class CreateCitizenBudgetModelVariableImpacts < ActiveRecord::Migration
  def change
    create_table :citizen_budget_model_impact_variables do |t|
      t.references :impact, index: true
      t.references :variable
      t.string :year
      t.decimal :coefficient
      t.integer :prepopulated_result

      t.timestamps
    end
  end
end
