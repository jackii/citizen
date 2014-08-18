require 'devise' # @see https://github.com/plataformatec/devise/wiki/How-To:-Use-devise-inside-a-mountable-engine#configuration
require 'citizen_budget_model/engine'
require 'acts_as_list'
require 'globalize'
require 'fast_gettext'
require 'protected_attributes' # needed by fast_gettext
require 'paranoia'

module CitizenBudgetModel
  # The parent controller all Popolo controllers inherit from. Defaults to
  # ApplicationController. This should be set early in the initialization
  # process and should be set to a string.
  #
  # @see https://github.com/plataformatec/devise/blob/master/lib/devise.rb#L196
  mattr_accessor :parent_controller
  @@parent_controller = 'ApplicationController'
end
