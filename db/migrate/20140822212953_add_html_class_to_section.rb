class AddHtmlClassToSection < ActiveRecord::Migration
  def change
    add_column :citizen_budget_model_sections, :html_class, :string, null: false, default: ''
  end
end
