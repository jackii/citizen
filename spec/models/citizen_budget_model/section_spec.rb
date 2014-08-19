require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe Section, type: :model do
    it { should validate_presence_of :simulator_id }
  end
end
