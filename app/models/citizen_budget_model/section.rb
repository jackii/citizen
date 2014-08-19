module CitizenBudgetModel
  class Section < ActiveRecord::Base
    acts_as_list scope: :simulator_id, top_of_list: 0
    translates :title, :description, :popover, :modal, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :simulator
    has_many :questions, -> { order(:position) }, dependent: :destroy

    validates_presence_of :simulator_id
  end
end
