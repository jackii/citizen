module CitizenBudgetModel
  class Impact < ActiveRecord::Base
    acts_as_list scope: :sensitivity_section_id, top_of_list: 0
    translates :name, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :sensitivity_section
  end
end
