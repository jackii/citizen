require 'rails_helper'

require 'citizen_budget_model/gettext_helper'

module CitizenBudgetModel
  RSpec.describe GetTextHelper do
    before(:all) do
      require 'citizen_budget_model/js_parser'
      GetText::Tools::XGetText.add_parser(CitizenBudgetModel::JsParser)
    end

    describe '.messages' do
      it 'should extract messages from .erb, .js and .rb files' do
        messages = GetTextHelper.messages('app/**/*.{erb,rb,js}')
        expect(messages).to include('Dummy') # .erb
        expect(messages).to include('bar') # .js
        expect(messages).to include('pong') # .rb
      end
    end
  end
end
