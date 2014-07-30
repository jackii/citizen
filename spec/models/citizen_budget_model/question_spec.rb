require 'spec_helper'

module CitizenBudgetModel
  describe Question do
    it { should validate_presence_of :section_id }
  end
end
