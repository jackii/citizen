module CitizenBudgetModel
  class User < ActiveRecord::Base
    devise :database_authenticatable,
           :recoverable, :rememberable, :trackable, :validatable

    belongs_to :organization
  end
end
