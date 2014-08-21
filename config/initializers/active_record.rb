ActiveRecord::Base.class_eval do
  def in_any_locale?(attribute)
    I18n.available_locales.any?{|locale| send(self.class.localized_attr_name_for(attribute, locale)).present?}
  end

  def any_of?(*attributes)
    translated, untranslated = attributes.partition{|attribute| self.class.translated_attribute_names.include?(attributes)}
    translated.any?{|attribute| in_any_locale?(attribute)} || untranslated.any?{|attribute| self[attribute].present?}
  end
end
