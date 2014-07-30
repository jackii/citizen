class CreateCitizenBudgetModelSections < ActiveRecord::Migration
  def up
    create_table :citizen_budget_model_sections do |t|
      t.belongs_to :simulator, index: true

      t.integer :position
      t.timestamps
    end
    CitizenBudgetModel::Section.create_translation_table!({
      title: :string,
      description: :text,
      popover: :text,
      modal: :text,
    })
  end

  def down
    drop_table :citizen_budget_model_sections
    CitizenBudgetModel::Section.drop_translation_table!
  end
end
