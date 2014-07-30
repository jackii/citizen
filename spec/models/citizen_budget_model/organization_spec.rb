require 'spec_helper'

module CitizenBudgetModel
  describe Organization do
    it { should validate_presence_of :name }
  end
end
