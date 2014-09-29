require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe Simulator, type: :model do
    let(:valid_attributes) do
      {
        organization_id: 1,
        name: 'Simulator',
      }
    end

    [:organization_id, :name].each do |attribute|
      it { should validate_presence_of attribute }
    end

    it 'should validate the equation' do
      expect(Simulator.new(valid_attributes.merge(equation: 'INVALID'))).to_not be_valid
    end

    describe '#activate!' do
      before(:each) do
        3.times do
          Simulator.create!(valid_attributes).activate!
        end
      end

      it 'should deactivate all active simulators and activate the given simulator' do
        simulator = Simulator.create!(valid_attributes)
        simulator.activate!
        expect(Simulator.where(active: true).count).to eq(1)
        expect(simulator.active).to eq(true)
      end
    end

    describe '#working_equation' do
      let(:simulator) do
        Simulator.new
      end

      it 'should return the equation if set' do
        simulator.equation = '1 + 1'
        expect(simulator.working_equation).to eq('1 + 1')
      end

      it 'should return a default equation it not set' do
        simulator.sections.build.questions.build({machine_name: 'var', default_value: 1, unit_value: 1})
        expect(simulator.working_equation).to eq('(var - 1.0) * 1.0')
      end
    end

    describe '#default_equation' do
      it 'should return the empty string if no variables' do
        simulator = Simulator.new
        expect(simulator.default_equation).to eq('')
      end

      it 'should return a default equation if variables' do
        simulator = Simulator.new
        1.upto(3) do |number|
          simulator.sections.build.questions.build({
            machine_name: "variable_#{number}",
            default_value: -number,
            unit_value: number * 1.5,
          })
        end
        expect(simulator.default_equation).to eq('(variable_1 - -1.0) * 1.5 + (variable_2 - -2.0) * 3.0 + (variable_3 - -3.0) * 4.5')
      end
    end
  end
end
