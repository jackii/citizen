module CitizenBudgetModel
  class Policy < ActiveRecord::Base
    translates :name, :unit_name, fallbacks_for_empty_translations: true
    globalize_accessors
  end
end

class CreateCitizenBudgetModelPolicies < ActiveRecord::Migration
  def up
    create_table :citizen_budget_model_policies do |t|
      t.references :policy_section, index: true
      t.string  :machine_name
      t.decimal :default_value
      t.decimal :minimum
      t.decimal :maximum
      t.decimal :step
      t.integer :position
      t.integer :year_1_value
      t.integer :year_2_value

      t.timestamps
    end
    CitizenBudgetModel::Policy.create_translation_table!({
      name: {type: :string, null: false, default: ''},
      unit_name: {type: :string, null: false, default: ''}
    })
  end
  def down
    drop_table :citizen_budget_model_policies
    CitizenBudgetModel::Policy.drop_translation_table!
  end
end
