# @see https://github.com/grosser/fast_gettext#rails
class CitizenBudgetModelController < CitizenBudgetModel.parent_controller.constantize
  include FastGettext::Translation

  before_filter :set_locale

  def set_locale
    session[:locale] = I18n.locale = FastGettext.set_locale(params[:locale] || session[:locale] ||  request.env['HTTP_ACCEPT_LANGUAGE'] || 'en-CA')
  end
end
