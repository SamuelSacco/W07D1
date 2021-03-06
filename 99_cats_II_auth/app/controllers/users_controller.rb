class UserController < ApplicationController
#   def index
#     @cats = Cat.all
#     render :index
#   end

#   def show
#     @cat = Cat.find(params[:id])
#     render :show
#   end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :user
    end
  end

#   def edit
#     @cat = Cat.find(params[:id])
#     render :edit
#   end

#   def update
#     @cat = Cat.find(params[:id])
#     if @cat.update_attributes(cat_params)
#       redirect_to cat_url(@cat)
#     else
#       flash.now[:errors] = @cat.errors.full_messages
#       render :edit
#     end
#   end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end