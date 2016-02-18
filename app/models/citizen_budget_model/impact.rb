module CitizenBudgetModel
  class Impact < ActiveRecord::Base
    acts_as_list scope: :sensitivity_section_id, top_of_list: 0
    translates :name, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :sensitivity_section
    has_many :impact_variables, -> { order(:year) }, dependent: :destroy
    accepts_nested_attributes_for :impact_variables
  end
end
