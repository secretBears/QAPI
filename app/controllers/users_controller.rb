class UsersController < ApplicationController
  before_action :authorize_admin
  before_action :set_user, only: [:edit, :update, :destroy, :toggle_admin]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html redirect_to edit_user_path(@user), notice: 'User was successfully created.'
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html redirect_to user_path(@user), notice: 'User was successfully updated.'
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully removed.' }
    end
  end

  def toggle_admin
    @user.toggle!(:admin) unless @user == current_user
    redirect_to users_path
  end

  private

  def authorize_admin
    authorize! :manage, User
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :type)
  end
end
