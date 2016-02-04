class CreateCitizenBudgetModelVariables < ActiveRecord::Migration
  def up
    create_table :citizen_budget_model_variables do |t|
      t.references :sensitivity, index: true
      t.string :machine_name
      t.decimal :default_value
      t.decimal :maximum
      t.decimal :minimum
      t.decimal :step
      t.integer :position
      t.decimal :pbo_assumption

      t.timestamps
    end

    CitizenBudgetModel::Variable.create_translation_table!({
      name: {type: :string, null: false, default: ''},
      unit_name: {type: :string, null: false, default: ''}
    })
  end

  def down
    drop_table :citizen_budget_model_variables
    CitizenBudgetModel::Variable.drop_translation_table!
  end
end
