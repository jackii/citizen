module CitizenBudgetModel
  class Simulator < ActiveRecord::Base
    validates_presence_of :name
  end
end
