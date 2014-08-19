class CitizenBudgetDeviseController < CitizenBudgetModel.parent_controller.constantize
  layout 'citizen_budget_model/devise'

  before_filter :set_locale

  def set_locale
    session[:locale] = I18n.locale = params[:locale] || session[:locale] ||  request.env['HTTP_ACCEPT_LANGUAGE'] || I18n.default_locale
  end
end
