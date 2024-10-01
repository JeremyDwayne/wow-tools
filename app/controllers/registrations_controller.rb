class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[new create]

  def new
    redirect_to root_url, notice: "You are already signed in." if authenticated?
    @user = User.new
  end

  def create
    @user = User.new(registration_params)

    if @user.save
      start_new_session_for @user
      redirect_to after_authentication_url, notice: "Signed up."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
