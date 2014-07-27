class Admin::UsersController < Admin::ApplicationController

  before_filter :set_user, only:[:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = I18n.t('admin.flashes.successfully_created')
      redirect_to admin_users_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if user_params[:password].blank?
      user_params.delete(:password) # Admin can't change the password of user
    end
    if @user.update(user_params)
      flash[:success] = I18n.t('admin.flashes.successfully_updated')
      redirect_to admin_users_url
    else
      render :edit
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :username, :email, :password)
    end

end
