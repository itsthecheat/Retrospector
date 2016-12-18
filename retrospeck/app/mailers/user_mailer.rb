class UserMailer < ActionMailer::Base
    default :from => "retrospecktest@gmail.com"

 def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.user_name} <#{user.email}>", :subject => "Registration Confirmation")
 end

end
