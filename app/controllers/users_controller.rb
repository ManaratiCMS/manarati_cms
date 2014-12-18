class UsersController < ApplicationControllerCore
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update,:mes_sites]
 
  def login
 
  end

  def create
#    @user = User.new(params[:user])
#    if @user.save
#      flash[:notice] = t("Inscription")[:msg][:compte_cree_avec_succes]
#      redirect_back_or_default account_url
#    else
#      @page.user = User.find_by_login("admin")
#      render :action => :new
#    end
  end

  # Esapce : Mon Bureau
  def show
   #   Affichage de Compte Utilisateur
   @user = @current_user
  end

  # Gestion de Mes Site Web
  def mes_sites
     @user = @current_user
     @sites = CmpSite.find(:all,:conditions=>["user_id = ?",@user.id])
 
  end
  def bienvenue
    
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end