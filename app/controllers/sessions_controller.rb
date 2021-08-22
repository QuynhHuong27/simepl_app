class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      check_remember params[:session][:remember_me], user
      flash[:success] = t "signup.message.success"
      redirect_back_or user
    else
      flash[:danger] = t "login.message.danger"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def check_remember remember_me, user
    remember_me == 1 ? remember(user) : forget(user)
  end
end
