module CitizenBudgetModel
  # @see https://github.com/globalize/globalize-accessors/issues/8
  class LocaleValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if I18n.available_locales.all?{|locale| record.translation_for(locale)[attribute].empty?}
        record.errors.add(attribute, :blank)
      end
    end
  end
end
