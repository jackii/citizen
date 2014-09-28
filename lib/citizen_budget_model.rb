require 'devise' # @see https://github.com/plataformatec/devise/wiki/How-To:-Use-devise-inside-a-mountable-engine#configuration
require 'citizen_budget_model/engine'
require 'acts_as_list'
require 'globalize'
require 'globalize-accessors'
require 'paranoia'
require 'redis'

module CitizenBudgetModel
  # The parent controller all Popolo controllers inherit from. Defaults to
  # ApplicationController. This should be set early in the initialization
  # process and should be set to a string.
  #
  # @see https://github.com/plataformatec/devise/blob/master/lib/devise.rb#L196
  mattr_accessor :parent_controller, instance_accessor: false
  @@parent_controller = 'ApplicationController'

  # The fields to hide from views. By default, all fields are visible.
  #
  # @example
  #   CitizenBudgetModel.hidden_fields = {
  #     section: [:description, :popover, :modal]
  #   }
  mattr_accessor :hidden_fields, instance_accessor: false
  @@hidden_fields = {}
end
