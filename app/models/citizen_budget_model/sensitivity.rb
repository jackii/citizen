module CitizenBudgetModel
  class Sensitivity < ActiveRecord::Base
    translates :name, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :organization
    has_many :variables, -> { order(:position) }, dependent: :destroy

    validates_presence_of :organization_id
    validates :name, 'citizen_budget_model/locale' => true

  end
end
