require 'spec_helper'

module CitizenBudgetModel
  describe Simulator do
    [:organization_id, :name].each do |attribute|
      it { should validate_presence_of attribute }
    end

    it 'should validate the equation' do
      simulator = Simulator.new(organization_id: 1, name: 'Simulator', equation: 'INVALID')
      simulator.valid?.should == false
    end
  end
end
