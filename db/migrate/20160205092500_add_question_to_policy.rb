class AddQuestionToPolicy < ActiveRecord::Migration
  def change
    add_column :citizen_budget_model_policies, :question_id, :integer
  end
end
