require 'rails_helper'

describe CitizenBudgetModel do
  context 'when using default options' do
    it 'should use default options' do
      expect(CitizenBudgetModel.parent_controller).to eq('ApplicationController')
      expect(CitizenBudgetModel.hidden_fields).to eq({})
    end
  end

  context 'when using custom options' do
    before(:all) do
      CitizenBudgetModel.parent_controller = 'CustomController'
      CitizenBudgetModel.hidden_fields = {section: [:description, :popover, :modal]}
    end

    after(:all) do
      CitizenBudgetModel.parent_controller = 'ApplicationController'
      CitizenBudgetModel.hidden_fields = {}
    end

    it 'should use custom options' do
      expect(CitizenBudgetModel.parent_controller).to eq('CustomController')
      expect(CitizenBudgetModel.hidden_fields).to eq({section: [:description, :popover, :modal]})
    end
  end
end
