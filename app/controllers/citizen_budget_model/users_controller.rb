module CitizenBudgetModel
  class UsersController < CitizenBudgetModelController
    before_action :authenticate_user!
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @users = collection.all.sort_by(&:email)
    end

    def show
    end

    def new
      @user = collection.new
    end

    def edit
    end

    def create
      @user = collection.new(user_params)

      if @user.save
        redirect_to users_path, notice: _('User was created.')
      else
        render :new
      end
    end

    def update
      if @user.update(user_params)
        redirect_to users_path, notice: _('User was updated.')
      else
        render :edit
      end
    end

  private

    def collection
      @collection ||= admin? ? CitizenBudgetModel::User : current_user.organization.users
    end

    def set_user
      @user = collection.find(params[:id])
    end

    def user_params
      attribute_names = [:email, :password, :password_confirmation]
      if admin?
        attribute_names << :organization_id
      end
      params.require(:user).permit(*attribute_names)
    end
  end
end
