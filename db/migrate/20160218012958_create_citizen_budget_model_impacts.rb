class CreateCitizenBudgetModelImpacts < ActiveRecord::Migration
  def up
    create_table :citizen_budget_model_impacts do |t|
      t.references :sensitivity_section, index: true
      t.string :machine_name
      t.integer :position
      t.decimal :year_1_coefficient
      t.integer :year_1_value
      t.decimal :year_2_coefficient
      t.integer :year_2_value
      t.decimal :year_5_coefficient
      t.integer :year_5_value

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
