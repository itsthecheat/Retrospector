class SessionsController < ApplicationController
  before_filter :authenticate_user, :only => [:home, :profile, :setting]
  before_filter :save_login_state, :only => [:login, :login_attempt]

  def login
    #Login Form
  end

  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
      if authorized_user
        # Put the confirmation in here
        if authorized_user.email_confirmed
            session[:user_id] = authorized_user.id
            flash[:notice] = "Welcome again, you were logged in as #{authorized_user.user_name}"
            redirect_to(:action => 'home')
        else
          flash.now[:error] = 'Please activate your account by following the
          instructions in the account confirmation email you received to proceed'
          render 'login'
        end
        # ends the confirmation error here
    else
      flash.now[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"
    end
  end

  def home
  end

  def profile
  end

  def setting
  end

  def logout
    session[:user_id] = nil
    redirect_to :action => 'login'
  end
end
