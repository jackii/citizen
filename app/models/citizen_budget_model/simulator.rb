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

    def activate!
      self.class.where(active: true).each do |simulator|
        simulator.update!(active: false)
      end
      update!(active: true)
    end

    def working_equation
      if equation?
        equation
      else
        default_equation
      end
    end

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
  end
end
