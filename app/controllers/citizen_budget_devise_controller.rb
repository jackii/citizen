# @see https://github.com/grosser/fast_gettext#rails
class CitizenBudgetDeviseController < CitizenBudgetModel.parent_controller.constantize
  include FastGettext::Translation
  helper_method :_

  layout 'citizen_budget_model/devise'

  before_filter :set_locale

  def set_locale
    session[:locale] = FastGettext.set_locale(params[:locale] || session[:locale] ||  request.env['HTTP_ACCEPT_LANGUAGE'] || 'en_CA')
  end
end