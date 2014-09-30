module CitizenBudgetModel
  class Simulator < ActiveRecord::Base
    acts_as_paranoid
    translates :name, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :organization
    has_many :sections, -> { order(:position) }, dependent: :destroy

    validates_presence_of :organization_id
    validates :name, 'citizen_budget_model/locale' => true
    validates :equation, 'citizen_budget_model/equation' => true, allow_blank: true

    # Sets the simulator as active and all others as inactive.
    def activate!
      self.class.where(active: true).each do |simulator|
        simulator.update!(active: false)
      end
      update!(active: true)
    end

    # Returns the equation or a default equation if not set.
    #
    # @return [String] an equation
    def working_equation
      if equation?
        equation
      else
        default_equation
      end
    end

    # Returns a default equation, where the difference between the chosen value
    # and the default value is multiplied by the unit value for each question.
    #
    # @return [String] a default equation
    def default_equation
      equation = []
      sections.each do |section|
        section.questions.each do |question|
          if question.machine_name? && question.default_value? && question.unit_value?
            equation << "(#{question.machine_name} - #{question.default_value}) * #{question.unit_value}"
          end
        end
      end
      equation.join(' + ')
    end

    # Solves the equation with the given variables' values.
    #
    # @param [Hash{<Symbol,String>=><Float,String>}] variables variables
    # @return [Float] a solution
    def solve(variables)
      keys = []
      values = []

      variables.each do |key,value|
        keys << key.to_sym
        values << Float(value)
      end

      # Struct will raise a NameError, whereas OpenStruct will not.
      eval(working_equation, Struct.new(*keys).new(*values).instance_eval{binding})
    end
  end
end
