require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe AdminHelper, type: :helper do
    describe '#value_formatter' do
      it 'should return a number as a percentage' do
        question = Question.new(unit_name: '%')
        expect(helper.value_formatter(question).call('2.10')).to eq('2.1%')
      end

      it 'should return a number as a currency' do
        question = Question.new(unit_name: '$')
        expect(helper.value_formatter(question).call('2.10')).to eq('$2.1')
      end

      it 'should return a number with precision' do
        question = Question.new
        expect(helper.value_formatter(question).call('2.10')).to eq('2.1')
      end

      it 'should accept options' do
        question = Question.new
        expect(helper.value_formatter(question, strip_insignificant_zeros: false).call('2.10')).to eq('2.100')
      end
    end

    describe '#percentage_formatter' do
      it 'should return a number as a percentage' do
        expect(helper.percentage_formatter.call('2.10')).to eq('2.1%')
      end

      it 'should accept options' do
        question = Question.new
        expect(helper.percentage_formatter(strip_insignificant_zeros: false).call('2.10')).to eq('2.100%')
      end
    end

    describe '#currency_formatter' do
      it 'should return a number as a currency' do
        expect(helper.currency_formatter.call('2.10')).to eq('$2.1')
      end

      it 'should accept options' do
        question = Question.new
        expect(helper.currency_formatter(strip_insignificant_zeros: false).call('2.10')).to eq('$2.10')
      end
    end

    describe '#precision_formatter' do
      it 'should return a number with precision' do
        expect(helper.precision_formatter.call('2.10')).to eq('2.1')
      end

      it 'should accept options' do
        question = Question.new
        expect(helper.precision_formatter(strip_insignificant_zeros: false).call('2.10')).to eq('2.100')
      end
    end

    describe '#visible?' do
      before(:all) do
        CitizenBudgetModel.hidden_fields = {section: [:description, :popover, :modal]}
      end

      after(:all) do
        CitizenBudgetModel.hidden_fields = {}
      end

      let(:record) do
        Section.new
      end

      it 'should return true if an attribute is visible' do
        expect(helper.visible?(record, :title)).to eq(true)
      end

      it 'should return false if an attribute is invisible' do
        expect(helper.visible?(record, :modal)).to eq(false)
      end

      it 'should return true if any attribute is visible' do
        expect(helper.visible?(record, :title, :modal)).to eq(true)
      end

      it 'should return false if no attribute is visible' do
        expect(helper.visible?(record, :popover, :modal)).to eq(false)
      end
    end

    describe '#present?' do
      let(:record) do
        Section.new(title: 'Section')
      end

      it 'should return true if an attribute is present' do
        expect(helper.present?(record, :title)).to eq(true)
      end

      it 'should return false if an attribute is blank' do
        expect(helper.present?(record, :modal)).to eq(false)
      end

      it 'should return true if any attribute is present' do
        expect(helper.present?(record, :title, :modal)).to eq(true)
      end

      it 'should return false if no attribute is present' do
        expect(helper.present?(record, :popover, :modal)).to eq(false)
      end
    end
  end
end
