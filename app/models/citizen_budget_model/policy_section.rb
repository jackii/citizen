module CitizenBudgetModel
  class PolicySection < ActiveRecord::Base
    acts_as_list scope: :multiplier_id, top_of_list: 0
    translates :name, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :multiplier
    has_many :policies

    validates_presence_of :multiplier_id
  end
end
