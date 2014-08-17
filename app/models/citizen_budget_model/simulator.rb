# @see https://github.com/swanandp/acts_as_list/blob/ac4f602d20b679370ed4bb9702ccc3fa61af1be8/README.md#example
module CitizenBudgetModel
  class Simulator < ActiveRecord::Base
    acts_as_paranoid
    translates :name

    belongs_to :organization
    has_many :sections, -> { order(:position) }, dependent: :destroy

    validates_presence_of :organization_id, :name
    validates :equation, equation: true, allow_blank: true
  end
end
