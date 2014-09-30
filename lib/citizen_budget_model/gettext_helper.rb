require 'gettext/tools/xgettext'

module CitizenBudgetModel
  module GetTextHelper
    # Returns all translateable messages from the engine and the app.
    #
    # @param [String] pattern a shell glob pattern
    # @return [Array<String>] all translateable messages
    def self.messages(pattern)
      # Add messages from the engine and the app.
      paths = Dir.glob([Engine.root.join(pattern), Rails.root.join(pattern)])
      keys = GetText::Tools::XGetText.new.parse(paths).map(&:msgid)

      # These will not be translated but only made human-readable.
      I18n.available_locales.each do |locale|
        keys << locale.to_s
      end

      # Add User model name and attribute names.
      keys << User.model_name.human
      %w(organization_id email password password_confirmation).each do |attribute_name|
        keys << User.human_attribute_name(attribute_name)
      end

      # Add other model names and attribute names.
      %w(Organization Simulator Section Question).each do |constant|
        klass = CitizenBudgetModel.const_get(constant)

        keys << klass.model_name.human
        (klass.attribute_names + klass.translated_attribute_names - %w(id position deleted_at created_at updated_at)).each do |attribute_name|
          keys << klass.human_attribute_name(attribute_name)
        end
      end

      # Add the virtual Question attribute names.
      %w(minimum maximum step).each do |attribute_name|
        keys << Question.human_attribute_name(attribute_name)
      end

      keys
    end
  end
end
