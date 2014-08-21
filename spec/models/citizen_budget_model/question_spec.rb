require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe Question, type: :model do
    it { should validate_presence_of :section_id }

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
