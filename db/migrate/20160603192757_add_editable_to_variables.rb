class AddEditableToVariables < ActiveRecord::Migration
  def change
    add_column :citizen_budget_model_variables, :public_editable, :boolean, default: true
  end
end
