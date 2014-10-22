require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe Question, type: :model do
    it { should validate_presence_of :section_id }
    it { should validate_uniqueness_of(:machine_name).scoped_to(:section_id) }
    it { should allow_value('', 'a', '_', 'aa', 'a_', 'a0', '_a', '__', '_0').for(:machine_name) }
    it { should_not allow_value('0', 'A', 'aA', '_A').for(:machine_name) } # too many to test
    it { should validate_exclusion_of(:machine_name).in_array(%w(all analyse)) } # testing all of them is slow
    [:default_value, :unit_value, :minimum, :maximum].each do |attribute|
      it { should validate_numericality_of attribute }
    end
    [:maxlength, :rows, :cols, :size].each do |attribute|
      it { should validate_numericality_of(attribute).only_integer.is_greater_than(0) }
    end
    it { should validate_numericality_of(:step).is_greater_than(0) }
    it { should validate_inclusion_of(:widget).in_array(%w(slider)) }

    it 'should get options' do
      question = Question.new(options: [1, 3, 5])
      expect(question.minimum).to eq(1)
      expect(question.maximum).to eq(5)
      expect(question.step).to eq(2)
    end

    it 'should get labels' do
      question = Question.new(labels: ['One', 'Two', 'Three'])
      expect(question.labels_as_list).to eq("One\nTwo\nThree")
    end

    it 'should set options' do
      question = Question.new(minimum: 1, maximum: 5, step: 2, default_value: 3)
      question.valid?
      expect(question.options).to eq([1, 3, 5])
    end

    it 'should add an additional option if the minimum is not steps from the default value' do
      question = Question.new(minimum: 0, maximum: 5, step: 2, default_value: 3)
      question.valid?
      expect(question.options).to eq([0, 1, 3, 5])
    end

    it 'should add an additional option if the maximum is not steps from the default value' do
      question = Question.new(minimum: 1, maximum: 6, step: 2, default_value: 3)
      question.valid?
      expect(question.options).to eq([1, 3, 5, 6])
    end

    it 'should set labels' do
      question = Question.new(labels_as_list: "One\nTwo\nThree")
      question.valid?
      expect(question.labels).to eq(['One', 'Two', 'Three'])
    end

    it 'should skip empty labels' do
      question = Question.new(labels_as_list: "\n \r\t\n\tOne\t\n Two \n\rThree\r")
      question.valid?
      expect(question.labels).to eq(['One', 'Two', 'Three'])
    end

    it 'should ensure all or none of maximum, minimum and step are present' do
      question = Question.new(section_id: 1, minimum: 0)
      question.valid?
      expect(question.errors.full_messages).to eq(["Maximum can't be blank", "Step can't be blank"])

      question = Question.new(section_id: 1, maximum: 0)
      question.valid?
      expect(question.errors.full_messages).to eq(["Minimum can't be blank", "Step can't be blank"])

      question = Question.new(section_id: 1, step: 1)
      question.valid?
      expect(question.errors.full_messages).to eq(["Minimum can't be blank", "Maximum can't be blank"])
    end

    it 'should ensure minimum is less than maximum' do
      question = Question.new(section_id: 1, minimum: 0, maximum: 0, step: 1, default_value: 0)
      question.valid?
      expect(question.errors.full_messages).to include('Minimum must be less than maximum')
    end

    it 'should validate presence of default value if options present' do
      question = Question.new(section_id: 1, options: [1, 2, 3])
      question.valid?
      expect(question.errors.full_messages).to eq(["Default value can't be blank"])

      question = Question.new(section_id: 1, minimum: 1, maximum: 5, step: 2)
      question.valid?
      expect(question.errors.full_messages).to eq(["Default value can't be blank"])
    end

    it 'should ensure default value is an option' do
      question = Question.new(section_id: 1, minimum: 1, maximum: 2, step: 1, default_value: 3)
      question.valid?
      expect(question.errors.full_messages).to eq(['Default value must be a valid option'])

      question = Question.new(section_id: 1, minimum: 1, maximum: 2, step: 1, default_value: 0)
      question.valid?
      expect(question.errors.full_messages).to eq(['Default value must be a valid option'])
    end

    it 'should ensure default value is a step away from the minimum' do
      question = Question.new(section_id: 1, minimum: 1, maximum: 6, step: 3, default_value: 3)
      question.valid?
      expect(question.errors.full_messages).to eq(['Default value must be a step away from the minimum'])
    end

    it 'should ensure default value is a step away from the maximum' do
      question = Question.new(section_id: 1, minimum: 0, maximum: 5, step: 3, default_value: 3)
      question.valid?
      expect(question.errors.full_messages).to eq(['Default value must be a step away from the maximum'])
    end

    it 'should ensure there are the same number of labels and options' do
      question = Question.new(section_id: 1, options: [1, 2, 3], default_value: 2, labels: ['Label'])
      question.valid?
      expect(question.errors.full_messages).to eq(['Labels must agree with options'])
    end

    describe '#name' do
      it 'should return the title' do
        expect(Question.new(name_en_ca: 'Name', title_en_ca: 'Title').display_name).to eq('Name')
        expect(Question.new(name_fr_ca: 'Name', title_fr_ca: 'Title').display_name).to eq('Name')
        expect(Question.new(title_en_ca: 'Question').display_name).to eq('Question')
        expect(Question.new(title_fr_ca: 'Question').display_name).to eq('Question')
      end

      it 'should return the default title' do
        expect(Question.new.display_name).to eq('Untitled')
        expect(Question.new(name_en_ca: '', title_en_ca: '').display_name).to eq('Untitled')
      end
    end

    describe '#working_equation' do
      it 'should return the equation if set' do
        skip
      end

      it 'should return a default equation it not set' do
        question = Question.new(machine_name: 'var', default_value: 1, unit_value: 2)
        expect(question.working_equation).to eq('(var - 1.0) * 2.0')
      end
    end

    describe '#default_equation' do
      it 'should return nil if missing variables' do
        question = Question.new(machine_name: 'incomplete')
        expect(question.default_equation).to eq(nil)
      end

      it 'should return a default equation if no missing variables' do
        question = Question.new(machine_name: 'var', default_value: 0, unit_value: 2)
        expect(question.working_equation).to eq('(var - 0.0) * 2.0')
      end
    end

    describe '#solve' do
      let(:question) do
        question = Question.new(machine_name: 'var', default_value: 1, unit_value: 2)
      end

      it 'should solve the equation' do
        expect(question.solve(4)).to eq(6)
      end

      it 'should coerce variable values' do
        expect(question.solve('4')).to eq(6)
      end

      it 'should error if value is nil' do
        expect{question.solve(nil)}.to raise_error(TypeError, "can't convert nil into Float")
      end
    end
  end
end
