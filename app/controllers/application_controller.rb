class ApplicationController < ActionController::Base


  # sécurité sur les formulaire
  protect_from_forgery

    # For plugin  Authlogic
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user # Authlogic


    #For Plugin  declaration_authorization-related code
  before_filter :set_current_user,:set_current_utilisateur
  filter_access_to :all

  # Timeout after inactivity of one hour.
  MAX_SESSION_PERIOD = 10000
  before_filter :session_expiry
 

private

  # trouver l'utilisateur connecté.
  def set_current_utilisateur
    @current_utilisateur ||= Utilisateur.find_by_id(session[:utilisateur_id]) if session[:utilisateur_id]
  end

  # Session
  def session_expiry
   if  session[:expiry_time]  and   current_user_session and session[:expiry_time] < Time.now
       current_user_session.destroy
       flash[:notice] = "Logout successful!"
       redirect_to "/"
   end
   session[:expiry_time] = MAX_SESSION_PERIOD.seconds.from_now
   return true
  end



  # set_current_user sets the global current user for this request.  This
  # is used by model security that does not have access to the
  # controller#current_user method.  It is called as a before_filter.
  def set_current_user
        user = User.new
#       user.roles = []
#        user.roles << "guest"
#    Authorization.current_user = user
    Authorization.current_user = current_user
  end
  # Fin declaration_authorization Module


  # Creation de Module Authlogic
  def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find

  end
  def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
  end
  def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
  end
  def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
  end
  def store_location
      session[:return_to] = request.request_uri
  end
  def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
  end
# fin de module








# Multi langue

def set_locale
  I18n.locale = extract_locale_from_subdomain
end

# Get locale code from request subdomain (like http://it.application.local:3000)
# You have to put something like:
#   127.0.0.1 gr.application.local
# in your /etc/hosts file to try this out locally
def extract_locale_from_subdomain
  parsed_locale = request.subdomains.first
  if parsed_locale.nil?
    nil
  else
  I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale  : nil
  end
end

end
