module CitizenBudgetModel
  class TranslationsController < CitizenBudgetModelController
    before_action :authenticate_user!, except: [:export]
    before_action :check_authorization!, except: [:export]

    def index
      @translations = Hash.new{|h,k| h[k] = {}}
      store = I18n.backend.backends.first.store
      store.keys.each do |k|
        locale, key = k.split('.', 2)
        @translations[key][locale.to_sym] = JSON.load(store[k])
      end

      @columns = I18n.available_locales.size + 1
    end

    def create
      if params[:pk] && params[:value]
        locale, key = params[:pk].split('.', 2)
        if I18n.backend.exists?(I18n.default_locale, key)
          I18n.backend.store_translations(locale, {key => params[:value]}, :escape => false)
          head :no_content
        else
          head :bad_request
        end
      else
        head :bad_request
      end
    end

    def export
      translations = {'' => {lang: I18n.locale}}
      store = I18n.backend.backends.first.store
      store.keys.each do |k|
        locale, key = k.split('.', 2)
        if locale.to_sym == I18n.locale
          translations[key.tr(I18n::Backend::Flatten::SEPARATOR_ESCAPE_CHAR, I18n::Backend::Flatten::FLATTEN_SEPARATOR)] = [nil, JSON.load(store[k])]
        end
      end
      # @note May need to add translations as necessary.
      %w(
        number.currency.format.delimiter
        number.currency.format.format
        number.currency.format.separator
        number.currency.format.unit
      ).each do |key|
        translations[key] = [nil, I18n.translate(key.to_sym)]
      end

      render json: translations
    end
  end
end
