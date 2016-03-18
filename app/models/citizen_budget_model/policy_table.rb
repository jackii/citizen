module CitizenBudgetModel
  class PolicyTable < ActiveRecord::Base
    translates :name, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :organization
    belongs_to :simulator
    has_many :policy_sections, -> { order(:position) }, dependent: :destroy

    validates_presence_of :organization_id
    validates :name, 'citizen_budget_model/locale' => true
    validates_numericality_of :growth_forecast, :employment_coefficient, greater_than: 0, allow_blank: true

    # Sets the simulator as active and all others as inactive.
    def activate!
      self.class.where(active: true).each do |policy_table|
        policy_table.update!(active: false)
      end
      update!(active: true)
    end

  end
end
