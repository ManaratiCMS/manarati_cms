class UserSessionsController < ApplicationControllerCore
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  def new
    @page.titre = t("UserSession.pages.new.titre")
    @page.description = t("UserSession.pages.new.description")
    @page.user = User.find_by_login("admin")
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      if has_role? :gestion_membre
        redirect_back_or_default account_url
      else
       redirect_to "/admin"
      end
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_user_session_url
  end
end
