module CitizenBudgetModel
  class PolicyTable < ActiveRecord::Base
    translates :name, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :organization
    belongs_to :simulator
    has_many :policy_sections

    validates_presence_of :organization_id
    validates :name, 'citizen_budget_model/locale' => true

    # Returns the equation or a default equation if not set.
    #
    # @return [String] an equation
    def working_equation
      default_equation
    end

    # Returns a default equation, where the difference between the chosen value
    # and the default value is multiplied by the unit value for each variable.
    #
    # @return [String] a default equation
    def default_equation
      equation = []
      policy_sections.each do |section|
        section.policies.each do |policy|
          equation << policy.question.working_equation
        end
        #section.questions.each do |question|
          #equation << question.working_equation
        #end
      end
      equation.reject(&:empty?).join(' + ')
    end
  end
end
