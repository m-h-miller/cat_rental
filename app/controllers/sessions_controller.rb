class SessionsController < ApplicationController
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

end
