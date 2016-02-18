module CitizenBudgetModel
  class ImpactVariable < ActiveRecord::Base
    belongs_to :impact
    belongs_to :variable
  end
end
