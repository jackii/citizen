require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe Question, type: :model do
    it { should validate_presence_of :section_id }

    describe '#name' do
      it 'should return the title' do
        expect(Question.new(title_en_ca: 'Question').name).to eq('Question')
        expect(Question.new(title_fr_ca: 'Question').name).to eq('Question')
      end

      it 'should return the default title' do
        expect(Question.new.name).to eq('Untitled')
        expect(Question.new(title_en_ca: '').name).to eq('Untitled')
      end
    end
  end
end
