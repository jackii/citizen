module CitizenBudgetModel
  class Simulator < ActiveRecord::Base
    acts_as_paranoid
    translates :name

    belongs_to :organization
    has_many :sections, dependent: :destroy

    validates_presence_of :organization_id, :name
  end
end
