class UsersController < ApplicationController
  # This controller was made using workshop materials

  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :require_login, except: [:new, :create]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  def update_status # This section allows admins to update a user's account status between active, suspended or banned.
    @user = User.find(params[:id])
  
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "User status updated successfully."
    else
      render :show
    end
  end

  def change_admin # This section allows admins to elavate or de-elavate user's account privileges.
    @user = User.find(params[:id])
    if current_user.is_admin?
      @user.update(is_admin: !@user.is_admin)
      redirect_to user_path(@user), notice: "User role updated."
    else
      redirect_to root_path, alert: "Permission denied."
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.html { redirect_to login_path, notice: "Sign up Successfully Completed. Please Log In." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @user = current_user
    if user_params[:password].present?
      if @user.update(user_params)
        redirect_to root_path, notice: "Password changed successfully."
      else
        render :edit
      end
    else
      # Skip updating the password attribute if it's blank
      if @user.update(user_params.except(:password))
        redirect_to root_path, notice: "User information updated successfully."
      else
        render :edit
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def delete # This section allows admins to delete users accounts
    @user = User.find(params[:id])
    if current_user == @user || current_user.is_admin?
      @user.destroy
      if current_user == @user
        # If the user is deleting their own account, log them out
        session[:user_id] = nil
      end
      redirect_to users_path, notice: "User account deleted."
    else
      redirect_to root_path, alert: "Permission denied."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:ufname, :ulname, :email, :is_admin, :status, :password, :current_password)
    end
end
