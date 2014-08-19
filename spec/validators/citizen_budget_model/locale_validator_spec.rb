require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe LocaleValidator do
    describe '#validate_each' do
      let :instance do
        Thing.new
      end

      it 'should not add an error if the name is present in one language' do
        instance.name_en_ca = 'Foo'
        expect(instance).to be_valid
        expect(instance.errors).to be_empty
      end

      it 'should not add an error if the name is present in another language' do
        instance.name_fr_ca = 'Foo'
        expect(instance).to be_valid
        expect(instance.errors).to be_empty
      end

      it 'should add an error if the name is blank' do
        expect(instance).to_not be_valid
        expect(instance.errors.full_messages).to eq(["Name can't be blank"])
      end
    end
  end
end
