module CitizenBudgetModel
  module AdminHelper
    # Formats as a percentage if the unit name is "%", as a currency if the unit
    # name is "$" and as a number otherwise.
    def value_formatter(question, options = {})
      if question.unit_name == '%'
        percentage_formatter(options)
      elsif question.unit_name == '$'
        currency_formatter(options)
      else
        precision_formatter(options)
      end
    end

    def percentage_formatter(options = {})
      lambda{|v|
        number_to_percentage(v, {strip_insignificant_zeros: true}.merge(options))
      }
    end

    def currency_formatter(options = {})
      lambda{|v|
        number_to_currency(v, {strip_insignificant_zeros: true}.merge(options))
      }
    end

    def precision_formatter(options = {})
      lambda{|v|
        number_with_precision(v, {strip_insignificant_zeros: true}.merge(options))
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
