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
