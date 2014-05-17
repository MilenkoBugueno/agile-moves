class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
      log_admin("AdminLog: User updated")
    else
      redirect_to users_path, :alert => "Unable to update user."
      log_admin("AdminLog: User update failed")
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
      log_admin("AdminLog: User destroyed")
    else
      redirect_to users_path, :notice => "Can't delete yourself."
      log_admin("AdminLog: User destroy self failed")
    end
  end
end