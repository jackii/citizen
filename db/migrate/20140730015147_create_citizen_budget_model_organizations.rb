class CreateCitizenBudgetModelOrganizations < ActiveRecord::Migration
  def up
    create_table :citizen_budget_model_organizations do |t|
      t.datetime :deleted_at, index: true
      t.timestamps
    end
    CitizenBudgetModel::Organization.create_translation_table!({
      name: {type: :string, null: false, default: ''},
    })
  end

  def down
    drop_table :citizen_budget_model_organizations
    CitizenBudgetModel::Organization.drop_translation_table!
  end
end
