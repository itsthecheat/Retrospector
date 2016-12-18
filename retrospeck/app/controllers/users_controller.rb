class UsersController < ApplicationController

  #For the new form method
  def new
    @user = User.new
  end

  #For the post method on the new page form
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
    end
    render "new"
  end

end
