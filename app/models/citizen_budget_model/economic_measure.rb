module CitizenBudgetModel
  class EconomicMeasure < ActiveRecord::Base
    acts_as_list scope: :policy_section_id, top_of_list: 0
    translates :name, :unit_name, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :policy_section
    belongs_to :question

    validates_presence_of :policy_section_id
    validates_presence_of :question_id
    validates :name, 'citizen_budget_model/locale' => true
    validates_uniqueness_of :machine_name, scope: :policy_section_id, allow_blank: true
    validates_format_of :machine_name, with: /\A[a-z_][a-z_0-9]*\z/, allow_blank: true
    validates_numericality_of :year_1_value, :year_2_value, allow_blank: true
  end
end
