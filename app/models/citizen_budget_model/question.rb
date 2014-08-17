module CitizenBudgetModel
  class Question < ActiveRecord::Base
    acts_as_list scope: :section
    translates :name, :title, :description, :modal, :popover, :labels, :unit_name, :placeholder

    belongs_to :section

    validates_presence_of :section_id
  end
end
