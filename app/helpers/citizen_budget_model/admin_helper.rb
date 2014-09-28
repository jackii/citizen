module CitizenBudgetModel
  module AdminHelper
    def value_formatter(question)
      if question.unit_name == '%'
        percentage_formatter
      elsif question.unit_name == '$'
        currency_formatter
      else
        precision_formatter
      end
    end

    def percentage_formatter
      lambda{|v|
        number_to_percentage(v, strip_insignificant_zeros: true)
      }
    end

    def currency_formatter
      lambda{|v|
        number_to_currency(v, strip_insignificant_zeros: true)
      }
    end

    def precision_formatter
      lambda{|v|
        number_with_precision(v, strip_insignificant_zeros: true)
      }
    end

    def visible?(record, *attributes)
      attributes.any? do |attribute|
        !CitizenBudgetModel.hidden_fields.fetch(record.class.model_name.param_key.to_sym, []).include?(attribute)
      end
    end
  end
end
