module CitizenBudgetModel
  class Organization < ActiveRecord::Base
    acts_as_paranoid
    translates :name
    globalize_accessors locales: ['en-CA', 'fr-CA']

    has_many :simulators, dependent: :destroy
    has_many :users

    validates_presence_of :name
  end
end
