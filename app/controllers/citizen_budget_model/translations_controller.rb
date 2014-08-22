module CitizenBudgetModel
  class TranslationsController < CitizenBudgetModelController
    before_action :authenticate_user!

    def index
      @translations = {}
      store = I18n.backend.backends.first.store
      store.keys.each do |k|
        locale, key = k.split('.', 2)
        @translations[key] ||= {}
        @translations[key][locale.to_sym] = JSON.load(store[k])
      end

      @columns = I18n.available_locales.size + 1
    end

    def create
      locale, key = params[:pk].split('.', 2)
      if I18n.backend.exists?(I18n.default_locale, key)
        I18n.backend.store_translations(locale, {key => params[:value]}, :escape => false)
        head :no_content
      else
        # Don't allow setting arbitrary keys.
        head :bad_request
      end
    end
  end
end
