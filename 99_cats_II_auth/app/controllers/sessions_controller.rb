class SessionsController < ApplicationController

  def new 
    render :new
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
  end

  private

  def user_params
        params.require(:user).permit(:user_name, :password)
  end
end