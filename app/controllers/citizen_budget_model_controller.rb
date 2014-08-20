class CitizenBudgetModelController < CitizenBudgetModel.parent_controller.constantize
  layout 'citizen_budget_model/admin'

  before_filter :set_locale

  def set_locale
    session[:locale] = I18n.locale = params[:locale] || session[:locale] || http_accept_language.compatible_language_from(I18n.available_locales) || I18n.default_locale
  end

  def admin?
    user_signed_in? && current_user.organization_id.nil?
  end
  helper_method :admin?
end

# There's no convention for where to put form builders such that they reload in development.
module CitizenBudgetModel
  class CitizenBudgetFormBuilder < ActionView::Helpers::FormBuilder
    def errors
      if object.errors.any?
        content = ActiveSupport::SafeBuffer.new
        object.errors.full_messages.each do |message|
          content << @template.content_tag(:li, message)
        end
        @template.content_tag(:div, @template.content_tag(:ul, content), class: 'alert alert-danger')
      end
    end

    def translated_text_field(method, options = {}) # @todo continue
      if object.class.translated_attribute_names.include?(method)
        object.class.globalize_locales.each do |locale|
          @template.concat(text_field(method, options, locale))
        end
        ''
      else
        text_field(method, options)
      end
    end

    def text_field(method, options = {}, locale = nil)
      field_method = method
      if locale
        field_method = object.class.localized_attr_name_for(method, locale)
      end
      klass = 'form-group'
      content = label(method) + super(field_method, {class: 'form-control'}.merge(options))
      if object.errors[method].any?
        klass << ' has-error has-feedback'
        content << @template.content_tag(:span, nil, class: 'glyphicon glyphicon-remove form-control-feedback')
      end
      @template.content_tag(:div, content, class: klass)
    end

    def select(method, choices = nil, options = {}, html_options = {})
      klass = 'form-group'
      content = label(method) + super(method, choices, options, {class: 'form-control'}.merge(html_options))
      if object.errors[method].any?
        klass << ' has-error has-feedback'
        content << @template.content_tag(:span, nil, class: 'glyphicon glyphicon-remove form-control-feedback')
      end
      @template.content_tag(:div, content, class: klass)
    end

    def buttons
      content = button(_('Save'), class: 'btn btn-primary')
      if object.persisted?
        content << @template.link_to(object, class: 'btn btn-danger pull-right', method: :delete, data: {confirm: _('Are you sure?')}) do
          @template.content_tag(:span, nil, class: 'glyphicon glyphicon-trash') + ' ' + _('Delete')
        end
      end
      content
    end
  end
end
