require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe Question, type: :model do
    it { should validate_presence_of :section_id }
  end
end
