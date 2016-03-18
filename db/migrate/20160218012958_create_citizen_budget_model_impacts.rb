class CreateCitizenBudgetModelImpacts < ActiveRecord::Migration
  def up
    create_table :citizen_budget_model_impacts do |t|
      t.references :sensitivity_section, index: true
      t.string :machine_name
      t.integer :position

      t.timestamps
    end
    CitizenBudgetModel::Impact.create_translation_table!({
      name: {type: :string, null: false, default: ''}
    })
  end
  def down
    drop_table :citizen_budget_model_impacts
    CitizenBudgetModel::Impact.drop_translation_table!
  end
end
