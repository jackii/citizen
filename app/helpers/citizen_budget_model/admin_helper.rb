module CitizenBudgetModel
  module AdminHelper
    # Formats as a percentage if the unit name is "%", as a currency if the unit
    # name is "$" and as a number otherwise.
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

    # Returns whether any of the given attributes are not hidden fields.
    #
    # @param record
    # @param attributes
    # @return [Boolean] whether any of the given attributes are not hidden fields
    # @see CitizenBudgetModel.hidden_fields
    def visible?(record, *attributes)
      attributes.any? do |attribute|
        !CitizenBudgetModel.hidden_fields.fetch(record.class.model_name.param_key.to_sym, []).include?(attribute)
      end
    end

    # Returns whether any of the given attributes are present.
    #
    # @param record
    # @param attributes
    # @return [Boolean] whether any of the given attributes are present
    def present?(record, *attributes)
      attributes.any? do |attribute|
        record[attribute].present?
      end
    end
  end
end
