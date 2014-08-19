require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe Organization, type: :model do
    it { should validate_presence_of :name }
  end
end
