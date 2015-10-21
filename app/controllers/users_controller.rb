class UsersController < ApplicationController
  before_action :redirect_if_signed_in

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_url(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    sign_in(@user)
    redirect_to cats_url
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :session_token, :password)
  end

  def redirect_if_signed_in
    redirect_to cats_url if signed_in?
  end

end
