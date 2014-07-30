require 'spec_helper'

module CitizenBudgetModel
  describe Section do
    it { should validate_presence_of :simulator_id }
  end
end
