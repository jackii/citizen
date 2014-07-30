require 'spec_helper'

module CitizenBudgetModel
  describe Simulator do
    [:organization_id, :name].each do |attribute|
      it { should validate_presence_of attribute }
    end
  end
end
