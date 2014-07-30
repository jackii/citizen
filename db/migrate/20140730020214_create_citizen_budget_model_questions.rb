class CreateCitizenBudgetModelQuestions < ActiveRecord::Migration
  def up
    create_table :citizen_budget_model_questions do |t|
      t.belongs_to :section, index: true

      # Simulation
      t.string :machine_name, null: false, default: ''
      t.float :default_value
      t.float :unit_value
      t.string :account, null: false, default: ''

      # Widget
      t.string :widget, null: false, default: ''
      t.float_array :options

      # Widget text
      t.boolean :revenue, default: false

      # HTML attributes
      t.integer :maxlength
      t.boolean :required, default: false
      t.integer :rows
      t.integer :cols
      t.integer :size

      t.integer :position
      t.timestamps
    end
    CitizenBudgetModel::Organization.create_translation_table!({
      # Simulation
      name: {type: :string, null: false, default: ''},

      # Question text
      title: {type: :text, null: false, default: ''},
      description: {type: :text, null: false, default: ''},
      modal: {type: :text, null: false, default: ''},
      popover: {type: :text, null: false, default: ''},

      # Widget
      labels: :string_array,

      # Widget text
      unit_name: {type: :string, null: false, default: ''},

      # HTML attributes
      placeholder: {type: :string, null: false, default: ''},
    })
  end

  def down
    drop_table :citizen_budget_model_organizations
    CitizenBudgetModel::Organization.drop_translation_table!
  end
end
