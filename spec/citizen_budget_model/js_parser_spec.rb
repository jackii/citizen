require 'rails_helper'

require 'citizen_budget_model/js_parser'

require 'tempfile'

module CitizenBudgetModel
  RSpec.describe JsParser do
    describe '.target?' do
      it 'returns true if the file extension is .js' do
        expect(JsParser.target?('/path/to/file.js')).to eq(true)
      end

      it 'returns false if the file extension is not .js' do
        expect(JsParser.target?('/path/to/file.rb')).to eq(false)
      end
    end

    describe '.parse' do
      STRING = <<-EOL
      function _(msgid) {
        return i18n.gettext(msgid);
      }

      alert(_('foo'));
      EOL

      let(:path) do
        file = Tempfile.new('file.js')
        file.write(STRING)
        file.rewind
        file.path
      end

      it 'returns PO entries' do
        po = JsParser.parse(path)
        expect(po.size).to eq(1)
        expect(po[0].msgid).to eq('foo')
        expect(po[0].references).to eq(["#{path}:5"])
      end
    end
  end
end
