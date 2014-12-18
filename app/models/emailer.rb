class Emailer < ActionMailer::Base
  
 def contact(recipient, subject, message, sent_at = Time.now)
      @subject = subject
      @recipients = recipient
      @from = 'essarraj.fouad@gmail.com'
      @sent_on = sent_at
	    @body["title"] =  'aa'
  	  @body["email"] = 'essarraj.fouad@gmail.com'
   	  @body["message"] = message
      @headers = {}
   end

 def reset_password_email(user)
  @user = user
  @password_reset_url = 'http://www.pilotedev.com/bureau/authentication/password_reset?' + @user.password_reset_token
  mail(:to => user.email, :subject => 'Password Reset Instructions.')
end
end
