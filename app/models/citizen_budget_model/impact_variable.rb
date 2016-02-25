module CitizenBudgetModel
  class ImpactVariable < ActiveRecord::Base
    belongs_to :impact
    belongs_to :variable

    validates_presence_of :impact_id
    validates_presence_of :variable_id
  end
end
