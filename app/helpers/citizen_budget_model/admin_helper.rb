module CitizenBudgetModel
  module AdminHelper
    def default_value_formatter(question)
      if question.unit_name == '%'
        lambda{|v|
          number_to_percentage(v, strip_insignificant_zeros: true)
        }
      elsif question.unit_name == '$'
        lambda{|v|
          number_to_currency(v, strip_insignificant_zeros: true)
        }
      else
        lambda{|v|
          number_with_precision(v, strip_insignificant_zeros: true)
        }
      end
    end

    def unit_value_formatter
      lambda{|v|
        number_to_currency(v, strip_insignificant_zeros: true)
      }
    end
  end
end
