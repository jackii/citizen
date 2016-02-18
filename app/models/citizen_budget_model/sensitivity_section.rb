module CitizenBudgetModel
  class SensitivitySection < ActiveRecord::Base
    acts_as_list scope: :sensitivity_id, top_of_list: 0
    translates :name, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :sensitivity
    has_many :impacts

    validates_presence_of :sensitivity_id

  end
end
