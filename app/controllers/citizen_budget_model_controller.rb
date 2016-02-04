class CitizenBudgetModelController < CitizenBudgetModel.parent_controller.constantize
  layout 'citizen_budget_model/admin'

  before_action :set_locale

  helper CitizenBudgetModel::Engine.helpers

  helper_method :admin?

  def set_locale
    session[:locale] = I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
  end

  def admin?
    user_signed_in? && current_user.organization_id.nil?
  end

  def check_authorization!
    unless admin?
      head :forbidden
    end
  end

  def multipliers
    @multipliers_collection ||= admin? ? CitizenBudgetModel::Multiplier : current_user.organization.multipliers
  end

  def simulators
    @simulators_collection ||= admin? ? CitizenBudgetModel::Simulator : current_user.organization.simulators
  end

  def users
    @users_collection ||= admin? ? CitizenBudgetModel::User : current_user.organization.users
  end

  def sort(collection)
    collection.each do |object|
      object.update_attributes position: params[object.class.model_name.param_key].index(object.id.to_s)
    end
    render nothing: true, status: 204
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
      translated(:text_field_without_label, method, options)
    end

    def translated_text_area(method, options = {})
      translated(:text_area_without_label, method, options)
    end

    alias_method :text_field_without_label, :text_field
    alias_method :text_area_without_label, :text_area

    def text_field(method, options = {})
      wrapper_and_label(method, super(method, default_options(options)))
    end

    def email_field(method, options = {})
      wrapper_and_label(method, super(method, default_options(options)))
    end

    def number_field(method, options = {})
      wrapper_and_label(method, super(method, default_options(options)))
    end

    def password_field(method, options = {})
      wrapper_and_label(method, super(method, default_options(options)))
    end

    def select(method, choices = nil, options = {}, html_options = {})
      wrapper_and_label(method, super(method, choices, options, default_options(options)))
    end

    def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
      return unless @template.visible?(object, method)

      content = @template.content_tag(:label, super(method, options, checked_value, unchecked_value) + ' ' + object.class.human_attribute_name(method))

      @template.content_tag(:div, content, class: 'checkbox')
    end

    def submit
      button(_('Save'), class: 'btn btn-primary')
    end

    def buttons(options = {})
      @template.concat(submit)

      if block_given?
        yield
      end

      if object.persisted?
        @template.concat(@template.link_to(options.fetch(:context, object), class: 'btn btn-danger pull-right', method: :delete, data: {confirm: _('Are you sure?')}) do
          @template.content_tag(:span, nil, class: 'glyphicon glyphicon-trash') + ' ' + _('Delete')
        end)
      end

      nil
    end

  private

    def default_options(options)
      {class: 'form-control'}.merge(options)
    end

    def label(method, text = nil, options = {})
      super(method, _(object.class.human_attribute_name(method)), options)
    end

    def wrapper_and_label(method, content)
      wrapper(method, label(method) + content)
    end

    def wrapper(method, content)
      return unless @template.visible?(object, method)

      klass = 'form-group'
      if object.errors[method].any?
        klass << ' has-error has-feedback'
        content << @template.content_tag(:span, nil, class: 'glyphicon glyphicon-remove form-control-feedback')
      end

      @template.content_tag(:div, content, class: klass)
    end

    def translated(helper, method, options)
      return unless @template.visible?(object, method)

      rows = ActiveSupport::SafeBuffer.new

      object.class.globalize_locales.each do |locale|
        method_name = object.class.localized_attr_name_for(method, locale)
        tag_id = "#{object.class.model_name.param_key}_#{method_name}"
        content = @template.content_tag(:label, _(locale), for: tag_id)
        content << send(helper, method_name, {class: 'form-control'}.merge(options))
        rows << @template.content_tag(:div, wrapper(method, content), class: 'col-sm-6')
      end

      label(method, nil, for: nil) + @template.content_tag(:div, rows, class: 'row')
    end
  end
end
