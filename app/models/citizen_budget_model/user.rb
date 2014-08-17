module CitizenBudgetModel
  class User < ActiveRecord::Base
    devise :database_authenticatable,
           :recoverable, :rememberable, :trackable, :validatable

    belongs_to :organization

    after_create do |user|
      user.send_reset_password_instructions
    end

    def password_required?
      new_record? ? false : super
    end
  end
end
