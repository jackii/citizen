class CreateCitizenBudgetModelPolicySections < ActiveRecord::Migration
  def up
    create_table :citizen_budget_model_policy_sections do |t|
      t.references :multiplier, index: true

      t.integer :position
      t.timestamps
    end
    CitizenBudgetModel::PolicySection.create_translation_table!({
      name: {type: :string, null: false, default: ''},
    })
 end

  def down
    drop_table :citizen_budget_model_policy_sections
    CitizenBudgetModel::PolicySection.drop_translation_table!
  end
end
