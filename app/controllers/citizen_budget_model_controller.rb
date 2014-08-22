class CitizenBudgetModelController < CitizenBudgetModel.parent_controller.constantize
  layout 'citizen_budget_model/admin'

  before_filter :set_locale

  helper_method :admin?

  def set_locale
    session[:locale] = I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
  end

  def admin?
    user_signed_in? && current_user.organization_id.nil?
  end

  def simulators
    @simulators_collection ||= admin? ? CitizenBudgetModel::Simulator : current_user.organization.simulators
  end
end

# There's no convention for where to put form builders such that they reload in
# development, or for how to load the form builders for testing.
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

    def translated_text_field(method, options = {})
      rows = ActiveSupport::SafeBuffer.new

      object.class.globalize_locales.each do |locale|
        klass = 'form-group'
        method_name = object.class.localized_attr_name_for(method, locale)
        tag_id = "#{object.class.model_name.param_key}_#{method_name}"
        content = @template.content_tag(:label, _(locale), for: tag_id)
        content << text_field_without_label(method_name, {class: 'form-control'}.merge(options))
        if object.errors[method].any?
          klass << ' has-error has-feedback'
          content << @template.content_tag(:span, nil, class: 'glyphicon glyphicon-remove form-control-feedback')
        end
        rows << @template.content_tag(:div, @template.content_tag(:div, content, class: klass), class: 'col-sm-6')
      end

      label(method) + @template.content_tag(:div, rows, class: 'row')
    end

    alias_method :text_field_without_label, :text_field

    def text_field(method, options = {})
      klass = 'form-group'
      content = label(method) + super(method, {class: 'form-control'}.merge(options))
      if object.errors[method].any?
        klass << ' has-error has-feedback'
        content << @template.content_tag(:span, nil, class: 'glyphicon glyphicon-remove form-control-feedback')
      end
      @template.content_tag(:div, content, class: klass)
    end

    def email_field(method, options = {})
      klass = 'form-group'
      content = label(method) + super(method, {class: 'form-control'}.merge(options))
      if object.errors[method].any?
        klass << ' has-error has-feedback'
        content << @template.content_tag(:span, nil, class: 'glyphicon glyphicon-remove form-control-feedback')
      end
      @template.content_tag(:div, content, class: klass)
    end

    def number_field(method, options = {})
      klass = 'form-group'
      content = label(method) + super(method, {class: 'form-control'}.merge(options))
      if object.errors[method].any?
        klass << ' has-error has-feedback'
        content << @template.content_tag(:span, nil, class: 'glyphicon glyphicon-remove form-control-feedback')
      end
      @template.content_tag(:div, content, class: klass)
    end

    def password_field(method, options = {})
      klass = 'form-group'
      content = label(method) + super(method, {class: 'form-control'}.merge(options))
      if object.errors[method].any?
        klass << ' has-error has-feedback'
        content << @template.content_tag(:span, nil, class: 'glyphicon glyphicon-remove form-control-feedback')
      end
      @template.content_tag(:div, content, class: klass)
    end

    def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
      content = @template.content_tag(:label, super(method, options, checked_value, unchecked_value) + ' ' + object.class.human_attribute_name(method))
      @template.content_tag(:div, content, class: 'checkbox')
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

    def submit
      button(_('Save'), class: 'btn btn-primary')
    end

    def buttons
      content = submit
      if object.persisted?
        content << @template.link_to(object_name, class: 'btn btn-danger pull-right', method: :delete, data: {confirm: _('Are you sure?')}) do
          @template.content_tag(:span, nil, class: 'glyphicon glyphicon-trash') + ' ' + _('Delete')
        end
      end
      content
    end
  end
end
