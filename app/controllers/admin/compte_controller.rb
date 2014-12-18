class Admin::CompteController < ApplicationControllerCoreAdmin
 layout "admin"
  def edit
    @user = @current_user
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = t("GestionUsers.msg.editer_avec_succes");
      redirect_to "/admin/"
    else
      render :action => :edit
    end
  end

end
