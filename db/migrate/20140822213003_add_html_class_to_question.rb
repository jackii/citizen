class AddHtmlClassToQuestion < ActiveRecord::Migration
  def change
    add_column :citizen_budget_model_questions, :html_class, :string, null: false, default: ''
  end
end
