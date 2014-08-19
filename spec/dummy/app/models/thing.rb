class Thing < ActiveRecord::Base
  translates :name
  globalize_accessors locales: ['en-CA', 'fr-CA']
  validates :name, 'citizen_budget_model/locale' => true
end
