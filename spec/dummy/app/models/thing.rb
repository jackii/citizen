class Thing < ActiveRecord::Base
  translates :name
  globalize_accessors
  validates :name, 'citizen_budget_model/locale' => true

  def ping
    _('pong')
  end
end
