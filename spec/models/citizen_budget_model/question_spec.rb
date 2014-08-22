require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe Question, type: :model do
    it { should validate_presence_of :section_id }
    it { should validate_uniqueness_of(:machine_name).scoped_to(:section_id) }
    it { should allow_value('', 'a', '_', 'aa', 'a_', 'a0', '_a', '__', '_0').for(:machine_name) }
    it { should_not allow_value('0', 'A', 'aA', '_A').for(:machine_name) } # too many to test
    it { should ensure_exclusion_of(:machine_name).in_array(%w(all analyse
      analyze and any array as asc asymmetric both case cast check collate
      column constraint create current_catalog current_date current_role
      current_time current_timestamp current_user default deferrable desc
      distinct do else end except false fetch for foreign from grant group
      having in initially intersect into lateral leading limit localtime
      localtimestamp not null offset on only or order placing primary references
      returning select session_user some symmetric table then to trailing true
      union unique user using variadic when where window with)) }

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
