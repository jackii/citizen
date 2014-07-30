class CreateCitizenBudgetModelQuestions < ActiveRecord::Migration
  def up
    create_table :citizen_budget_model_questions do |t|
      t.belongs_to :section, index: true

      # Simulation
      t.string :machine_name
      t.float :default_value
      t.float :unit_value
      t.string :account

      # Widget
      t.string :widget
      t.float_array :options

      # Widget text
      t.boolean :revenue

      # HTML attributes
      t.integer :maxlength
      t.boolean :required
      t.integer :rows
      t.integer :cols
      t.integer :size

      t.integer :position
      t.timestamps
    end
    CitizenBudgetModel::Organization.create_translation_table!({
      # Simulation
      name: :string,

      # Question text
      title: :text,
      description: :text,
      modal: :text,
      popover: :text,

      # Widget
      labels: :string_array,

      # Widget text
      unit_name: :string,

      # HTML attributes
      placeholder: :string,
    })
  end

  def down
    drop_table :citizen_budget_model_organizations
    CitizenBudgetModel::Organization.drop_translation_table!
  end
end
