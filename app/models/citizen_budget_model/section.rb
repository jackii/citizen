module CitizenBudgetModel
  class Section < ActiveRecord::Base
    acts_as_list scope: :simulator
    translates :title, :description, :popover, :modal

    belongs_to :simulator
    has_many :questions, dependent: :destroy

    validates_presence_of :simulator_id
  end
end
