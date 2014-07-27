class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      sign_in user
      flash[:success] = I18n.t('auth.flashes.sign_in_successfully')
      redirect_to root_url
    else
      flash.now[:danger] = I18n.t('auth.flashes.invalid_username_password_combination')
      render :new
    end
  end

  def destroy
    flash[:success] = I18n.t('auth.flashes.sign_out_successfully')
    sign_out
    redirect_to root_url
  end

  private

    def session_params
      params.require(:session).permit(:email, :password)
    end

end
