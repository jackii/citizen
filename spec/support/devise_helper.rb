# @see https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-3-and-4-%28and-RSpec%29
module DeviseHelper
  def login
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in CitizenBudgetModel::User.create!(email: 'user@example.com')
    end
  end
end