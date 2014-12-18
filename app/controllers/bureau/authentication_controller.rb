class Bureau::AuthenticationController < ApplicationControllerCore


  def  sign_in
    @user = Utilisateur.new

  end

  def login
    username_or_email = params[:user][:login]
    password = params[:user][:password]

    if username_or_email.rindex('@')
      email=username_or_email
      user = Utilisateur.authenticate_by_email(email, password)
    else
      username=username_or_email
      user = Utilisateur.authenticate_by_username(username, password)
    end

   if user
    flash[:notice] = 'Bienvenue'
    session[:utilisateur_id] = user.id
    redirect_to "/bureau/profile"
  else
    flash.now[:error] = t("GestionUtilisateurs.profile.erreur_connexion") 
    render :action => "sign_in"
  end
  end



  def signed_out
  session[:utilisateur_id] = nil
  flash[:notice] = t("GestionUtilisateurs.profile.deconnection")
  redirect_to "/"
  end

  def account_settings
  @user = @current_utilisateur
  end
  def set_account_info
  old_user = @current_utilisateur

  # verify the current password by creating a new user record.
  @user = Utilisateur.authenticate_by_username(old_user.username, params[:user][:password])

  # verify
  if @user.nil?
    @user = @current_utilisateur
    @user.errors[:password] = "Password is incorrect."
    render :action => "account_settings"
  else
    # update the user with any new username and email
    @user.update(params[:user])
    # Set the old email and username, which is validated only if it has changed.
    @user.previous_email = old_user.email
    @user.previous_username = old_user.username

    if @user.valid?
      # If there is a new_password value, then we need to update the password.
      @user.password = @user.new_password unless @user.new_password.nil? || @user.new_password.empty?
      @user.save
      flash[:notice] = 'Account settings have been changed.'
      redirect_to :root
    else
      render :action => "account_settings"
    end
  end
end

  def change_password


  end
  def  forgot_password
 @user = Utilisateur.new
  end
  def password_sent
    
  end

  def send_password_reset_instructions
  username_or_email = params[:user][:username]

  if username_or_email.rindex('@')
    user = Utilisateur.find_by_email(username_or_email)
  else
    user = Utilisateur.find_by_username(username_or_email)
  end

  if user
    user.password_reset_token = SecureRandom.urlsafe_base64
    user.password_expires_after = 24.hours.from_now
    user.save
    
   
    Emailer.reset_password_email(user,@message).deliver
    flash[:notice] = 'Password instructions have been mailed to you. Please check your inbox.'
    redirect_to "/bureau/authentication/sign_in"
  else
    @user = User.new
    # put the previous value back.
    @user.username = params[:user][:username]
    @user.errors[:username] = 'is not a registered user.'
    render :action => "forgot_password"
  end
end
end
