%%{
  machine validator;

  # http://www.postgresql.org/docs/current/static/sql-syntax-lexical.html#SQL-SYNTAX-IDENTIFIERS
  operator = [*/+\-];
  number   = '-'? digit+ ('.' digit+)?;
  word     = [a-z_][a-z_0-9]*;
  group    = '(' @{ fcall rest; };
  factor   = number | word | group;
  # Strong difference to prevent SQL comments.
  expr     = (space* factor (space* operator space* factor)* space*) -- '--';
  rest    := expr ')' @{ fret; };

  main := expr;
}%%

module CitizenBudgetModel
  # Validates the format of simple mathematical formula.
  class FormulaValidator < ActiveModel::EachValidator
    %% write data;
    #% # fix highlighting

    # Returns whether a formula is valid.
    #
    # @param [String] value a formula
    # @return [Boolean] whether the formula is valid
    # @see http://stackoverflow.com/questions/12015684/simple-ragel-example-that-balances-parentheses
    def self.valid?(value)
      data = value.unpack('c*')
      stack = []

      %% write init;
      %% write exec;

      # Ensure all parentheses are closed and the state machine is in a final state.
      top.zero? && cs >= validator_first_final
    end

    def validate_each(record, attribute, value)
      record.errors.add(attribute, :invalid, options.merge(value: value)) unless self.class.valid?(value)
    end
  end
end
