class CreateCitizenBudgetModelSimulators < ActiveRecord::Migration
  def up
    create_table :citizen_budget_model_simulators do |t|
      t.belongs_to :organization, index: true

      t.string :equation, null: false, default: ''
      t.string :distribution, null: false, default: ''

      t.datetime :deleted_at, index: true
      t.timestamps
    end
    CitizenBudgetModel::Simulator.create_translation_table!({
      name: {type: :string, null: false, default: ''},
    })
  end

  def down
    drop_table :citizen_budget_model_simulators
    CitizenBudgetModel::Simulator.drop_translation_table!
  end
end
