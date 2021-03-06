class UsersController < ApplicationController
  before_action :find_user, except: %i(index new create)
  before_action :logged_in_user, only: %i(index edit update)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.all
  end



  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:success] = t "signup.message.success"
      redirect_to root_path
    else
      flash[:danger] = t "signup.message.fail"
      render :new
    end
  end

  def edit; end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def update
    if @user.update user_params
      flash[:success] = t "update.message.success"
      redirect_to @user
    else
      flash.now[:danger] = t "update.message.fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user.noti.destroy_true"
    else
      flash[:danger] = t "user.noti.destroy_fail"
    end
    redirect_to users_path
  end

  private

  def find_user
    @user = User.find params[:id]
    return if @user

    flash[:danger] = t "signup.message.login"
    redirect_to @user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                        :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
