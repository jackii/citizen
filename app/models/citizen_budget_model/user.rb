module CitizenBudgetModel
  class User < ActiveRecord::Base
    devise :database_authenticatable,
           :recoverable, :rememberable, :trackable, :validatable

    belongs_to :organization

    after_create do |user|
      user.send_reset_password_instructions
    end

    # Returns whether a password is required.
    #
    # A password is not require to create a new user as an administrator.
    #
    # @return [Boolean] returns whether a password is required
    def password_required?
      new_record? ? false : super
    end
  end
end
