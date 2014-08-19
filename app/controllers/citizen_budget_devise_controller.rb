class CitizenBudgetDeviseController < CitizenBudgetModel.parent_controller.constantize
  layout 'citizen_budget_model/devise'

  before_filter :set_locale

  def set_locale
    session[:locale] = I18n.locale = params[:locale] || session[:locale] || http_accept_language.compatible_language_from(I18n.available_locales) || I18n.default_locale
  end
end
