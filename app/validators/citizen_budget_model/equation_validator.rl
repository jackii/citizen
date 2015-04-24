%%{
  machine validator;

  # http://www.postgresql.org/docs/current/static/sql-syntax-lexical.html#SQL-SYNTAX-IDENTIFIERS
  operator = [*/+\-];
  number   = '-'? digit+ ('.' digit+)?;
  word     = [a-z_][a-z_0-9]*;
  group    = '(' @{ fcall rest; };
  # The ternary operator is not SQL, but it is Ruby and JavaScript.
  ternary  = word space* '<' space* number space* '?' space* number space* ':' space* number;
  factor   = number | word | ternary | group;
  # Strong difference to prevent SQL comments.
  expr     = (space* factor (space* operator space* factor)* space*) -- '--';
  rest    := expr ')' @{ fret; };

  main := expr;
}%%

module CitizenBudgetModel
  # Validates the format of simple mathematical equation.
  class EquationValidator < ActiveModel::EachValidator
    %% write data;
    #% # fix highlighting

    # Returns whether an equation is valid.
    #
    # @param [String] value an equation
    # @return [Boolean] whether the equation is valid
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
