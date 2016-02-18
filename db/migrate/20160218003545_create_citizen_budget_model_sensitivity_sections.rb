class CreateCitizenBudgetModelSensitivitySections < ActiveRecord::Migration
  def up
    create_table :citizen_budget_model_sensitivity_sections do |t|
      t.references :sensitivity
      t.integer :position

      t.timestamps
    end
    add_index :citizen_budget_model_sensitivity_sections, ["sensitivity_id"],
      :unique => true, :name => 'index_citizen_budget_model_sensitivity_sections_sensitivity_id'
    CitizenBudgetModel::SensitivitySection.create_translation_table!({
      name: {type: :string, null: false, default: ''},
    })
  end

  def down
    drop_table :citizen_budget_model_sensitivity_sections
    CitizenBudgetModel::SensitivitySection.drop_translation_table!
  end
end
