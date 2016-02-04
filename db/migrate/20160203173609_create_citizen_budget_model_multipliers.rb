class CreateCitizenBudgetModelMultipliers < ActiveRecord::Migration
  def up
    create_table :citizen_budget_model_multipliers do |t|
      t.references :organization
      t.integer :growth_forecast
      t.decimal :employment_coeffiecient
      t.boolean :active, default: true

      t.timestamps
    end
    CitizenBudgetModel::Multiplier.create_translation_table!({
      name: {type: :string, null: false, default: ''},
    })
  end
  def down
    drop_table :citizen_budget_model_multipliers
    CitizenBudgetModel::Multiplier.drop_translation_table!
  end

end
