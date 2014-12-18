class AdministrationController <  ApplicationControllerCore
  def index
    if current_user.nil?
      redirect_to "/user_session/new"
    else
      redirect_to "/admin"
    end
  end
end
