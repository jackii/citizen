require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe Section, type: :model do
    it { should validate_presence_of :simulator_id }

    describe '#name' do
      it 'should return the title' do
        expect(Section.new(title_en_ca: 'Section').display_name).to eq('Section')
        expect(Section.new(title_fr_ca: 'Section').display_name).to eq('Section')
      end

      it 'should return the default title' do
        expect(Section.new.display_name).to eq('Untitled')
        expect(Section.new(title_en_ca: '').display_name).to eq('Untitled')
      end
    end
  end
end
