require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe Simulator, type: :model do
    [:organization_id, :name].each do |attribute|
      it { should validate_presence_of attribute }
    end

    it 'should validate the equation' do
      expect(Simulator.new(organization_id: 1, name: 'Simulator', equation: 'INVALID')).to_not be_valid
    end
  end
end
