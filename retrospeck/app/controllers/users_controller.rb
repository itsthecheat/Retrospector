class UsersController < ApplicationController

  before_filter :save_login_state, :only => [:new, :create]

  #For the new form method
  def new
    @user = User.new
  end

  #For the post method on the new page form
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
    end
    render "new"
  end
  #Fix because this is like some hybrid version of 4/5
  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :salt, :encrypted_password)
  end



end
