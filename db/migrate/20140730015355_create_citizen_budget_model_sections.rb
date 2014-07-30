class CreateCitizenBudgetModelSections < ActiveRecord::Migration
  def up
    create_table :citizen_budget_model_sections do |t|
      t.belongs_to :simulator, index: true

      t.integer :position
      t.timestamps
    end
    CitizenBudgetModel::Section.create_translation_table!({
      title: {type: :string, null: false, default: ''},
      description: {type: :text, null: false, default: ''},
      popover: {type: :text, null: false, default: ''},
      modal: {type: :text, null: false, default: ''},
    })
  end

  def down
    drop_table :citizen_budget_model_sections
    CitizenBudgetModel::Section.drop_translation_table!
  end
end
