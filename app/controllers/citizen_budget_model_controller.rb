# @see https://github.com/grosser/fast_gettext#rails
class CitizenBudgetModelController < CitizenBudgetModel.parent_controller.constantize
  include FastGettext::Translation
  helper_method :_

  layout 'citizen_budget_model/admin'

  before_filter :set_locale

  def set_locale
    session[:locale] = FastGettext.set_locale(params[:locale] || session[:locale] ||  request.env['HTTP_ACCEPT_LANGUAGE'] || 'en_CA')
  end

  def admin?
    user_signed_in? && current_user.organization_id.nil?
  end
  helper_method :admin?
end
