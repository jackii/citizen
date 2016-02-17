class CreateCitizenBudgetModelSensitivies < ActiveRecord::Migration
  def up
    create_table :citizen_budget_model_sensitivities do |t|
      t.references :organization
      t.timestamps
    end

    CitizenBudgetModel::Sensitivity.create_translation_table!({
      name: {type: :string, null: false, default: ''}
    })
  end

  def down
    drop_table :citizen_budget_model_sensitivities
    CitizenBudgetModel::Sensitivity.drop_translation_table!
  end
end
