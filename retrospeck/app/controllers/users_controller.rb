class UsersController < ApplicationController

  before_filter :save_login_state, :only => [:new, :create]
  helper_method :username


  #For the new form method
  def new
    @user = User.new
  end

  #For the post method on the new page form
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      # flash[:notice] = "You signed up successfully"
      # flash[:color]= "valid"
      flash[:notice] = "Please confirm your email to continue"
    else
      # flash[:notice] = "Form is invalid"
      # flash[:color]= "invalid"
      flash[:error] = 'Oops, something went wrong.'
    end
    render "users/new"
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to Retrospeck! Your email has been confirmed.
      Please sign in to continue."
      redirect_to "/login"
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to "/"
    end
  end

  def show
    @reviews = Review.where(user_id: params[:id])
    @user = User.find_by(id: params[:id])
  end

  #Fix because this is like some hybrid version of 4/5
  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :salt, :encrypted_password)
  end


end
