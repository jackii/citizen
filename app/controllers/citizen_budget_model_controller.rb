class CitizenBudgetModelController < CitizenBudgetModel.parent_controller.constantize
  include FastGettext::Translation

  before_filter :set_gettext_locale

  def set_gettext_locale
    session[:locale] = FastGettext.set_locale(params[:locale] || session[:locale] ||  request.env['HTTP_ACCEPT_LANGUAGE'] || 'en_CA')
  end
end
