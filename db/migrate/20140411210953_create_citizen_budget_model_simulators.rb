class CreateCitizenBudgetModelSimulators < ActiveRecord::Migration
  def change
    create_table :citizen_budget_model_simulators do |t|
      t.string :name
      t.string :equation
      t.string :distribution

      t.timestamps
    end
  end
end
