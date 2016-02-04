module CitizenBudgetModel
  class PolicySection < ActiveRecord::Base
    acts_as_list scope: :policy_table_id, top_of_list: 0
    translates :name, :popover, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :policy_table
    has_many :economic_measures, -> { order(:position) }, dependent: :destroy

    validates_presence_of :policy_table_id
    validates :name, 'citizen_budget_model/locale' => true
  end
end
