class Admin::UsersController < Admin::BaseController
  before_filter :find_user, :only => [:show, :edit, :update, :destroy]

  def index
    @users = User.all(:order => 'email')
  end

  def show

  end

  def new
    @user = User.new
  end

  def create
    attr = params[:user].dup
    attr.delete(:admin)
    @user = User.new(attr)
    set_admin
    if @user.save
      flash[:notice] = "User has been created."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been created."
      render :action => :new
    end
  end


  def edit

  end

  def update
    attr = params[:user].dup
    attr.delete(:admin)
    set_admin
    
    # don't update blank password 
    if attr[:password].blank?
      attr.delete(:password)
      attr.delete(:password_confirmation)
    end

    if @user.update_attributes(attr)
      flash[:notice] = "User has been updated."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been updated."
      render :action => 'edit'
    end
  end

  def destroy
    if current_user == @user
      flash[:alert] = "You cannot delete yourself!"
    else
      @user.destroy
      flash[:notice] = "User has been deleted."
    end
    redirect_to admin_users_path
  end

private 
  def find_user
    @user = User.find(params[:id])
  end

  # dry: set_admin
  def set_admin
    @user.admin = params[:user][:admin] == '1'
  end
end
