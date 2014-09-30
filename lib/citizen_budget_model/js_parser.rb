require 'gettext/po_entry'

module CitizenBudgetModel
  # Extracts messages from `.js` files.
  #
  # @see GetText::ErbParser
  # @see GetText::RubyParser
  class JsParser
    class << self
      # Returns whether the parser can parse the file.
      #
      # @param [String] file a filename
      # @return [Boolean] whether the parser can parse the file
      def target?(file)
        File.extname(file) == '.js'
      end

      def parse(path, options={})
        parser = new(path, options)
        parser.parse
      end
    end

    # Initializers the parser.
    #
    # @param [String] path path to `.js` file to be parsed
    # @param [Hash] options
    def initialize(path, options={})
      @path = path
      @options = options
    end

    # Matches anything like:
    #
    # * `_('...')`
    # * `_("...")`
    # * `_('...', ...)`
    # * `_("...", ...)`
    #
    # It doesn't match the empty string, as it is reserved by Gettext.
    PATTERN = /\b_\(('[^']+'|"[^"]+")[),]/

    # Extracts messages from the `.js` file.
    #
    # @return [Array<POEntry>] the extracted messages
    # @see https://github.com/nubis/gettext_i18n_rails_js/blob/master/lib/gettext_i18n_rails_js/js_and_coffee_parser.rb
    def parse
      po = []
      IO.foreach(@path).each_with_index do |line,line_no|
        line.scan(PATTERN).each do |matches|
          po_entry = GetText::POEntry.new(:normal)
          po_entry.msgid = matches[0][1...-1]
          po_entry.references << "#{@path}:#{line_no + 1}"
          po << po_entry
        end
      end
      po
    end
  end
end
