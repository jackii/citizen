require 'spec_helper'

describe CitizenBudgetModel::EquationValidator do
  describe '.valid?' do
    it 'should return true if the equation is valid' do
      [ # number
        '1',
        '12',
        '1.2',
        '12.34',
        '-1',
        '-12',
        '-1.2',
        '-12.34',
        # word
        'v',
        '_',
        'var_1',
        '_var_1',
        # group
        '(1)',
        '(v)',
        '((1))',
        # operator
        '1*1',
        '1/a',
        'a+1',
        'a-a',
        # expr
        '1+(a+(2+(b)))*c-d/(e)',
        # spacing
        ' 1 ',
        ' ( 1 ) ',
        ' 1 + 1 ',
        # double negative
        '1 - -1',
      ].each do |equation|
        CitizenBudgetModel::EquationValidator.valid?(equation).should == true
      end
    end

    it 'should return false if the equation is invalid' do
      [ '',
        # number
        '1.',
        '.1',
        '-',
        '-1.',
        '-.1',
        '0x1',
        '1,1',
        # word
        'V',
        '9_',
        'var_A',
        '_var_A',
        # group
        '()',
        # operator
        '+1',
        '1++',
        '1--',
        '1%2',
        '1\\2',
        # expr
        '(1',
        '(a',
        '1+',
        'a+',
        '1 2',
        '1 b',
        'a 2',
        'a b',
        '1a',
        '*',
        # double negative
        '1--1',
      ].each do |equation|
        CitizenBudgetModel::EquationValidator.valid?(equation).should == false
      end
    end

    describe '#validate_each' do
      let :klass do
        Class.new do
          include ActiveModel::Validations

          attr_accessor :equation

          validates :equation, 'citizen_budget_model/equation' => true

          def self.name
            'Thing'
          end
        end
      end

      let :instance do
        klass.new
      end

      it 'should not add an error if the equation is valid' do
        instance.equation = '1+1'
        instance.valid?.should == true
        instance.errors.should be_empty
      end

      it 'should add an error if the equation is invalid' do
        instance.equation = ''
        instance.valid?.should == false
        instance.errors.full_messages.should == ['Equation is invalid']
      end
    end
  end
end
