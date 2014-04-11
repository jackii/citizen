
# line 1 "app/validators/citizen_budget_model/formula_validator.rl"

# line 15 "app/validators/citizen_budget_model/formula_validator.rl"


module CitizenBudgetModel
  # Validates the format of simple mathematical formula.
  class FormulaValidator < ActiveModel::EachValidator
    
# line 12 "app/validators/citizen_budget_model/formula_validator.rb"
class << self
	attr_accessor :_validator_actions
	private :_validator_actions, :_validator_actions=
end
self._validator_actions = [
	0, 1, 0, 1, 1
]

class << self
	attr_accessor :_validator_key_offsets
	private :_validator_key_offsets, :_validator_key_offsets=
end
self._validator_key_offsets = [
	0, 0, 10, 19, 21, 23, 33, 41, 
	50, 61, 63, 73, 86, 88, 95, 105, 
	114, 126
]

class << self
	attr_accessor :_validator_trans_keys
	private :_validator_trans_keys, :_validator_trans_keys=
end
self._validator_trans_keys = [
	32, 40, 45, 95, 9, 13, 48, 57, 
	97, 122, 32, 40, 95, 9, 13, 48, 
	57, 97, 122, 48, 57, 48, 57, 32, 
	40, 45, 95, 9, 13, 48, 57, 97, 
	122, 32, 41, 45, 47, 9, 13, 42, 
	43, 32, 40, 95, 9, 13, 48, 57, 
	97, 122, 32, 41, 45, 46, 47, 9, 
	13, 42, 43, 48, 57, 48, 57, 32, 
	41, 45, 47, 9, 13, 42, 43, 48, 
	57, 32, 41, 45, 47, 95, 9, 13, 
	42, 43, 48, 57, 97, 122, 48, 57, 
	32, 45, 47, 9, 13, 42, 43, 32, 
	45, 46, 47, 9, 13, 42, 43, 48, 
	57, 32, 45, 47, 9, 13, 42, 43, 
	48, 57, 32, 45, 47, 95, 9, 13, 
	42, 43, 48, 57, 97, 122, 0
]

class << self
	attr_accessor :_validator_single_lengths
	private :_validator_single_lengths, :_validator_single_lengths=
end
self._validator_single_lengths = [
	0, 4, 3, 0, 0, 4, 4, 3, 
	5, 0, 4, 5, 0, 3, 4, 3, 
	4, 0
]

class << self
	attr_accessor :_validator_range_lengths
	private :_validator_range_lengths, :_validator_range_lengths=
end
self._validator_range_lengths = [
	0, 3, 3, 1, 1, 3, 2, 3, 
	3, 1, 3, 4, 1, 2, 3, 3, 
	4, 0
]

class << self
	attr_accessor :_validator_index_offsets
	private :_validator_index_offsets, :_validator_index_offsets=
end
self._validator_index_offsets = [
	0, 0, 8, 15, 17, 19, 27, 34, 
	41, 50, 52, 60, 70, 72, 78, 86, 
	93, 102
]

class << self
	attr_accessor :_validator_indicies
	private :_validator_indicies, :_validator_indicies=
end
self._validator_indicies = [
	0, 2, 3, 5, 0, 4, 5, 1, 
	0, 2, 5, 0, 4, 5, 1, 6, 
	1, 4, 1, 7, 8, 9, 11, 7, 
	10, 11, 1, 12, 13, 14, 7, 12, 
	7, 1, 7, 8, 11, 7, 10, 11, 
	1, 12, 13, 14, 15, 7, 12, 7, 
	10, 1, 16, 1, 12, 13, 14, 7, 
	12, 7, 16, 1, 12, 13, 14, 7, 
	11, 12, 7, 11, 11, 1, 10, 1, 
	17, 18, 0, 17, 0, 1, 17, 18, 
	19, 0, 17, 0, 4, 1, 17, 18, 
	0, 17, 0, 6, 1, 17, 18, 0, 
	5, 17, 0, 5, 5, 1, 1, 0
]

class << self
	attr_accessor :_validator_trans_targs
	private :_validator_trans_targs, :_validator_trans_targs=
end
self._validator_trans_targs = [
	1, 0, 13, 4, 14, 16, 15, 5, 
	6, 12, 8, 11, 6, 17, 7, 9, 
	10, 13, 2, 3
]

class << self
	attr_accessor :_validator_trans_actions
	private :_validator_trans_actions, :_validator_trans_actions=
end
self._validator_trans_actions = [
	0, 0, 1, 0, 0, 0, 0, 0, 
	1, 0, 0, 0, 0, 3, 0, 0, 
	0, 0, 0, 0
]

class << self
	attr_accessor :validator_start
end
self.validator_start = 1;
class << self
	attr_accessor :validator_first_final
end
self.validator_first_final = 13;
class << self
	attr_accessor :validator_error
end
self.validator_error = 0;

class << self
	attr_accessor :validator_en_rest
end
self.validator_en_rest = 5;
class << self
	attr_accessor :validator_en_main
end
self.validator_en_main = 1;


# line 21 "app/validators/citizen_budget_model/formula_validator.rl"
    #% # fix highlighting

    # Returns whether a formula is valid.
    #
    # @param [String] value a formula
    # @return [Boolean] whether the formula is valid
    # @see http://stackoverflow.com/questions/12015684/simple-ragel-example-that-balances-parentheses
    def self.valid?(value)
      data = value.unpack('c*')
      stack = []

      
# line 160 "app/validators/citizen_budget_model/formula_validator.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = validator_start
	top = 0
end

# line 33 "app/validators/citizen_budget_model/formula_validator.rl"
      
# line 170 "app/validators/citizen_budget_model/formula_validator.rb"
begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_keys = _validator_key_offsets[cs]
	_trans = _validator_index_offsets[cs]
	_klen = _validator_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p].ord < _validator_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p].ord > _validator_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _validator_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p].ord < _validator_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p].ord > _validator_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	_trans = _validator_indicies[_trans]
	cs = _validator_trans_targs[_trans]
	if _validator_trans_actions[_trans] != 0
		_acts = _validator_trans_actions[_trans]
		_nacts = _validator_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _validator_actions[_acts - 1]
when 0 then
# line 8 "app/validators/citizen_budget_model/formula_validator.rl"
		begin
 	begin
		stack[top] = cs
		top+= 1
		cs = 5
		_trigger_goto = true
		_goto_level = _again
		break
	end
 		end
when 1 then
# line 12 "app/validators/citizen_budget_model/formula_validator.rl"
		begin
 	begin
		top -= 1
		cs = stack[top]
		_trigger_goto = true
		_goto_level = _again
		break
	end
 		end
# line 274 "app/validators/citizen_budget_model/formula_validator.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	end
	if _goto_level <= _out
		break
	end
	end
	end

# line 34 "app/validators/citizen_budget_model/formula_validator.rl"

      # Ensure all parentheses are closed and the state machine is in a final state.
      top.zero? && cs >= validator_first_final
    end

    def validate_each(record, attribute, value)
      record.errors.add(attribute, :invalid, options.merge(value: value)) unless self.class.valid?(value)
    end
  end
end
