module CitizenBudgetModel
  class EconomicMeasure < ActiveRecord::Base
    acts_as_list scope: :policy_section_id, top_of_list: 0
    translates :name, :unit_name, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :policy_section
    belongs_to :question

    validates_presence_of :policy_section_id
    validates_uniqueness_of :machine_name, scope: :policy_section_id, allow_blank: true
    validates_format_of :machine_name, with: /\A[a-z_][a-z_0-9]*\z/, allow_blank: true
    validates_numericality_of :default_value, :year_1_value, :year_2_value, :minimum, :maximum, allow_blank: true
    validates_numericality_of :step, greater_than: 0, allow_blank: true

    validate :all_or_none_of_minimum_and_maximum_and_step_should_be_present
    validate :minimum_must_be_less_than_maximum

    def all_or_none_of_minimum_and_maximum_and_step_should_be_present
      unless minimum.present? && maximum.present? && step.present? || minimum.blank? && maximum.blank? && step.blank?
        [:minimum, :maximum, :step].each do |attribute|
          if send(attribute).blank?
            errors.add(attribute, :blank)
          end
        end
      end
    end

    def minimum_must_be_less_than_maximum
      if minimum.present? && maximum.present? && minimum.to_f >= maximum.to_f
        errors.add(:minimum, _('must be less than maximum'))
      end
    end
  end
end
