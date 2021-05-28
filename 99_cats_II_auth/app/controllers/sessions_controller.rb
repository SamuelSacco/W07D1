class SessionsController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]
  before_action :require_logged_in, only: [:destroy]

  def new 
    # render :new
  end

  def create
    @user = User.find_by_credentials(
        params[:user][:user_name],
        params[:user][:password]
    )
    if @user
        login!(user)
        redirect_to cats_url
    else
        render :new
    end
  end

  def destroy
    self.logout!
    redirect_to new_session_url
  end

  private

  def user_params
        params.require(:user).permit(:user_name, :password)
  end
end