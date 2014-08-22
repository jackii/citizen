require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe Question, type: :model do
    it { should validate_presence_of :section_id }
    it { should validate_uniqueness_of(:machine_name).scoped_to(:section_id) }
    it { should allow_value('', 'a', '_', 'aa', 'a_', 'a0', '_a', '__', '_0').for(:machine_name) }
    it { should_not allow_value('0', 'A', 'aA', '_A').for(:machine_name) } # too many to test
    it { should ensure_exclusion_of(:machine_name).in_array(%w(all analyse)) } # testing all of them is slow
    [:default_value, :unit_value, :minimum, :maximum].each do |attribute|
      it { should validate_numericality_of attribute }
    end
    [:maxlength, :rows, :cols, :size].each do |attribute|
      it { should validate_numericality_of(attribute).only_integer.is_greater_than(0) }
    end
    it { should validate_numericality_of(:step).is_greater_than(0) }
    it { should ensure_inclusion_of(:widget).in_array(%w(slider)) }

    it 'should ensure minimum is less than maximum' do
      question = Question.new(section_id: 1, minimum: 0, maximum: 0)
      question.valid?
      expect(question.errors.full_messages).to eq(['Minimum must be less than maximum'])
    end

    it 'should ensure default value is between minimum and maximum' do
      question = Question.new(section_id: 1, minimum: 1, maximum: 2, default_value: 3)
      question.valid?
      expect(question.errors.full_messages).to eq(['Default value must be between minimum and maximum'])

      question = Question.new(section_id: 1, minimum: 1, maximum: 2, default_value: 0)
      question.valid?
      expect(question.errors.full_messages).to eq(['Default value must be between minimum and maximum'])
    end

    it 'should ensure default value is an option' do
      question = Question.new(section_id: 1, options: [1, 2, 3], default_value: 0)
      question.valid?
      expect(question.errors.full_messages).to eq(['Default value must be a valid option'])
    end

    it 'should ensure there are the same number of labels and options' do
      question = Question.new(section_id: 1, options: [1, 2, 3], labels: ['Label'])
      question.valid?
      expect(question.errors.full_messages).to eq(['Labels must match options'])
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
  end
end
