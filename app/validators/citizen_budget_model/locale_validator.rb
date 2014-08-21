module CitizenBudgetModel
  # @see https://github.com/globalize/globalize-accessors/issues/8
  class LocaleValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if I18n.available_locales.all?{|locale| record.send(record.class.localized_attr_name_for(attribute, locale)).blank?}
        record.errors.add(attribute, :blank)
      end
    end
  end
end
