class SessionsController < ApplicationController
  before_action :redirect_if_signed_in, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if user
      sign_in(user)
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
    sign_out(current_user)
    redirect_to new_session_url
  end

  private

  def redirect_if_signed_in
    redirect_to cats_url if signed_in?
  end

end
