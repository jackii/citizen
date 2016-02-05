module CitizenBudgetModel
  class Multiplier < ActiveRecord::Base
    translates :name, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :organization
    belongs_to :simulator
    has_many :policy_sections

    validates_presence_of :organization_id
    validates :name, 'citizen_budget_model/locale' => true

  end
end
