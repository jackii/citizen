module CitizenBudgetModel
  class Variable < ActiveRecord::Base
    acts_as_list scope: :sensitivity_id, top_of_list: 0
    translates :name, :unit_name, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :sensitivity
  end
end
