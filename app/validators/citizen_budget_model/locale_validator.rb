module CitizenBudgetModel
  # @see https://github.com/globalize/globalize-accessors/issues/8
  class LocaleValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless record.in_any_locale?(attribute)
        record.errors.add(attribute, :blank)
      end
    end
  end
end
