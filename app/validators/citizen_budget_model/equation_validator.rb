
# line 1 "app/validators/citizen_budget_model/equation_validator.rl"

# line 17 "app/validators/citizen_budget_model/equation_validator.rl"


module CitizenBudgetModel
  # Validates the format of simple mathematical equation.
  class EquationValidator < ActiveModel::EachValidator
    
# line 12 "app/validators/citizen_budget_model/equation_validator.rb"
class << self
	attr_accessor :_validator_trans_keys
	private :_validator_trans_keys, :_validator_trans_keys=
end
self._validator_trans_keys = [
	0, 0, 9, 122, 9, 122, 
	48, 57, 9, 57, 48, 
	57, 9, 63, 9, 63, 
	9, 57, 48, 57, 9, 58, 
	9, 58, 9, 57, 48, 
	57, 48, 57, 9, 58, 
	48, 57, 9, 63, 9, 122, 
	9, 47, 9, 122, 9, 
	57, 48, 57, 9, 57, 
	9, 122, 9, 60, 9, 57, 
	48, 57, 9, 63, 9, 
	63, 9, 57, 48, 57, 
	9, 58, 9, 58, 9, 57, 
	48, 57, 48, 57, 9, 
	58, 48, 57, 9, 63, 
	9, 47, 9, 57, 9, 57, 
	9, 122, 9, 60, 0, 
	0, 0
]

class << self
	attr_accessor :_validator_key_spans
	private :_validator_key_spans, :_validator_key_spans=
end
self._validator_key_spans = [
	0, 114, 114, 10, 49, 10, 55, 55, 
	49, 10, 50, 50, 49, 10, 10, 50, 
	10, 55, 114, 39, 114, 49, 10, 49, 
	114, 52, 49, 10, 55, 55, 49, 10, 
	50, 50, 49, 10, 10, 50, 10, 55, 
	39, 49, 49, 114, 52, 0
]

class << self
	attr_accessor :_validator_index_offsets
	private :_validator_index_offsets, :_validator_index_offsets=
end
self._validator_index_offsets = [
	0, 0, 115, 230, 241, 291, 302, 358, 
	414, 464, 475, 526, 577, 627, 638, 649, 
	700, 711, 767, 882, 922, 1037, 1087, 1098, 
	1148, 1263, 1316, 1366, 1377, 1433, 1489, 1539, 
	1550, 1601, 1652, 1702, 1713, 1724, 1775, 1786, 
	1842, 1882, 1932, 1982, 2097, 2150
]

class << self
	attr_accessor :_validator_indicies
	private :_validator_indicies, :_validator_indicies=
end
self._validator_indicies = [
	0, 0, 0, 0, 0, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 0, 
	1, 1, 1, 1, 1, 1, 1, 2, 
	1, 1, 1, 1, 3, 1, 1, 4, 
	4, 4, 4, 4, 4, 4, 4, 4, 
	4, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 5, 1, 
	5, 5, 5, 5, 5, 5, 5, 5, 
	5, 5, 5, 5, 5, 5, 5, 5, 
	5, 5, 5, 5, 5, 5, 5, 5, 
	5, 5, 1, 0, 0, 0, 0, 0, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 0, 1, 1, 1, 1, 1, 
	1, 1, 2, 1, 1, 1, 1, 1, 
	1, 1, 4, 4, 4, 4, 4, 4, 
	4, 4, 4, 4, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 5, 1, 5, 5, 5, 5, 5, 
	5, 5, 5, 5, 5, 5, 5, 5, 
	5, 5, 5, 5, 5, 5, 5, 5, 
	5, 5, 5, 5, 5, 1, 6, 6, 
	6, 6, 6, 6, 6, 6, 6, 6, 
	1, 7, 7, 7, 7, 7, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	7, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 8, 1, 1, 
	9, 9, 9, 9, 9, 9, 9, 9, 
	9, 9, 1, 9, 9, 9, 9, 9, 
	9, 9, 9, 9, 9, 1, 10, 10, 
	10, 10, 10, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 10, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 11, 1, 9, 9, 9, 
	9, 9, 9, 9, 9, 9, 9, 1, 
	1, 1, 1, 1, 12, 1, 10, 10, 
	10, 10, 10, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 10, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 12, 1, 12, 12, 
	12, 12, 12, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 12, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 13, 1, 1, 14, 14, 14, 
	14, 14, 14, 14, 14, 14, 14, 1, 
	14, 14, 14, 14, 14, 14, 14, 14, 
	14, 14, 1, 15, 15, 15, 15, 15, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 15, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	16, 1, 14, 14, 14, 14, 14, 14, 
	14, 14, 14, 14, 17, 1, 15, 15, 
	15, 15, 15, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 15, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 17, 
	1, 17, 17, 17, 17, 17, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	17, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 3, 1, 1, 
	4, 4, 4, 4, 4, 4, 4, 4, 
	4, 4, 1, 4, 4, 4, 4, 4, 
	4, 4, 4, 4, 4, 1, 18, 18, 
	18, 18, 18, 18, 18, 18, 18, 18, 
	1, 15, 15, 15, 15, 15, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	15, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	18, 18, 18, 18, 18, 18, 18, 18, 
	18, 18, 17, 1, 19, 19, 19, 19, 
	19, 19, 19, 19, 19, 19, 1, 10, 
	10, 10, 10, 10, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 10, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 19, 19, 
	19, 19, 19, 19, 19, 19, 19, 19, 
	1, 1, 1, 1, 1, 12, 1, 20, 
	20, 20, 20, 20, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 20, 1, 
	1, 1, 1, 1, 1, 1, 21, 1, 
	1, 1, 1, 22, 1, 1, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 24, 1, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 1, 25, 25, 25, 25, 25, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 25, 1, 1, 1, 1, 1, 1, 
	1, 1, 26, 20, 20, 1, 27, 1, 
	20, 1, 20, 20, 20, 20, 20, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 20, 1, 1, 1, 1, 1, 1, 
	1, 21, 1, 1, 1, 1, 1, 1, 
	1, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	24, 1, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 1, 25, 25, 25, 
	25, 25, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 25, 1, 1, 1, 
	1, 1, 1, 1, 1, 26, 20, 20, 
	1, 27, 28, 20, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 1, 29, 
	29, 29, 29, 29, 29, 29, 29, 29, 
	29, 1, 25, 25, 25, 25, 25, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 25, 1, 1, 1, 1, 1, 1, 
	1, 1, 26, 20, 20, 1, 27, 1, 
	20, 29, 29, 29, 29, 29, 29, 29, 
	29, 29, 29, 1, 30, 30, 30, 30, 
	30, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 30, 1, 1, 1, 1, 
	1, 1, 1, 1, 26, 20, 20, 1, 
	27, 1, 20, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 1, 1, 31, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 24, 1, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 1, 30, 
	30, 30, 30, 30, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 30, 1, 
	1, 1, 1, 1, 1, 1, 1, 26, 
	20, 20, 1, 27, 1, 20, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 31, 1, 31, 31, 31, 31, 
	31, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 31, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	32, 1, 1, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 1, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	1, 34, 34, 34, 34, 34, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	34, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 35, 1, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 1, 1, 1, 1, 1, 36, 
	1, 34, 34, 34, 34, 34, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	34, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 36, 
	1, 36, 36, 36, 36, 36, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	36, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 37, 1, 1, 
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 1, 38, 38, 38, 38, 38, 
	38, 38, 38, 38, 38, 1, 39, 39, 
	39, 39, 39, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 39, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 40, 1, 38, 38, 38, 
	38, 38, 38, 38, 38, 38, 38, 41, 
	1, 39, 39, 39, 39, 39, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	39, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 41, 1, 41, 41, 41, 41, 
	41, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 41, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	22, 1, 1, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 1, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	1, 42, 42, 42, 42, 42, 42, 42, 
	42, 42, 42, 1, 39, 39, 39, 39, 
	39, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 39, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 42, 42, 42, 42, 42, 
	42, 42, 42, 42, 42, 41, 1, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 1, 34, 34, 34, 34, 34, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 34, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 1, 1, 1, 1, 1, 
	36, 1, 44, 44, 44, 44, 44, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 44, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 0, 0, 1, 45, 1, 
	0, 1, 44, 44, 44, 44, 44, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 44, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 0, 0, 1, 45, 46, 
	0, 4, 4, 4, 4, 4, 4, 4, 
	4, 4, 4, 1, 44, 44, 44, 44, 
	44, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 44, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 0, 0, 1, 
	45, 1, 0, 6, 6, 6, 6, 6, 
	6, 6, 6, 6, 6, 1, 47, 47, 
	47, 47, 47, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 47, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 0, 
	0, 1, 45, 1, 0, 5, 5, 5, 
	5, 5, 5, 5, 5, 5, 5, 1, 
	1, 7, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 5, 1, 5, 5, 
	5, 5, 5, 5, 5, 5, 5, 5, 
	5, 5, 5, 5, 5, 5, 5, 5, 
	5, 5, 5, 5, 5, 5, 5, 5, 
	1, 47, 47, 47, 47, 47, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	47, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 0, 0, 1, 45, 1, 0, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 7, 1, 1, 0
]

class << self
	attr_accessor :_validator_trans_targs
	private :_validator_trans_targs, :_validator_trans_targs=
end
self._validator_trans_targs = [
	1, 0, 40, 13, 41, 43, 42, 4, 
	5, 6, 7, 16, 8, 9, 10, 11, 
	14, 12, 15, 17, 18, 19, 35, 21, 
	24, 19, 45, 20, 22, 23, 25, 26, 
	27, 28, 29, 38, 30, 31, 32, 33, 
	36, 34, 37, 39, 40, 2, 3, 44
]

class << self
	attr_accessor :_validator_trans_actions
	private :_validator_trans_actions, :_validator_trans_actions=
end
self._validator_trans_actions = [
	0, 0, 1, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 1, 0, 0, 
	0, 0, 2, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0
]

class << self
	attr_accessor :validator_start
end
self.validator_start = 1;
class << self
	attr_accessor :validator_first_final
end
self.validator_first_final = 40;
class << self
	attr_accessor :validator_error
end
self.validator_error = 0;

class << self
	attr_accessor :validator_en_rest
end
self.validator_en_rest = 18;
class << self
	attr_accessor :validator_en_main
end
self.validator_en_main = 1;


# line 23 "app/validators/citizen_budget_model/equation_validator.rl"
    #% # fix highlighting

    # Returns whether an equation is valid.
    #
    # @param [String] value an equation
    # @return [Boolean] whether the equation is valid
    # @see http://stackoverflow.com/questions/12015684/simple-ragel-example-that-balances-parentheses
    def self.valid?(value)
      data = value.unpack('c*')
      stack = []

      
# line 402 "app/validators/citizen_budget_model/equation_validator.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = validator_start
	top = 0
end

# line 35 "app/validators/citizen_budget_model/equation_validator.rl"
      
# line 412 "app/validators/citizen_budget_model/equation_validator.rb"
begin
	testEof = false
	_slen, _trans, _keys, _inds, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
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
	_keys = cs << 1
	_inds = _validator_index_offsets[cs]
	_slen = _validator_key_spans[cs]
	_wide = data[p].ord
	_trans = if (   _slen > 0 && 
			_validator_trans_keys[_keys] <= _wide && 
			_wide <= _validator_trans_keys[_keys + 1] 
		    ) then
			_validator_indicies[ _inds + _wide - _validator_trans_keys[_keys] ] 
		 else 
			_validator_indicies[ _inds + _slen ]
		 end
	cs = _validator_trans_targs[_trans]
	if _validator_trans_actions[_trans] != 0
	case _validator_trans_actions[_trans]
	when 1 then
# line 8 "app/validators/citizen_budget_model/equation_validator.rl"
		begin
 	begin
		stack[top] = cs
		top+= 1
		cs = 18
		_goto_level = _again
		next
	end
 		end
	when 2 then
# line 14 "app/validators/citizen_budget_model/equation_validator.rl"
		begin
 	begin
		top -= 1
		cs = stack[top]
		_goto_level = _again
		next
	end
 		end
# line 470 "app/validators/citizen_budget_model/equation_validator.rb"
	end
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

# line 36 "app/validators/citizen_budget_model/equation_validator.rl"

      # Ensure all parentheses are closed and the state machine is in a final state.
      top.zero? && cs >= validator_first_final
    end

    def validate_each(record, attribute, value)
      record.errors.add(attribute, :invalid, options.merge(value: value)) unless self.class.valid?(value)
    end
  end
end
