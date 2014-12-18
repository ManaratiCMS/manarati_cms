# Gestion de Membre
class Admin::UsersManagerController < ApplicationControllerCoreAdmin
 layout "admin"

  # Affichage de Toutes les User
  def index
    @page = CmpPage.new(:titre=>t("GestionUsers.titre_de_gestion"))
    @users = User.find(:all)
  end


  # Formulaire d'editer une User
  def edit
    @user = User.find(params[:id])
    @roles = CmpPack.find(:all)
  end

  # Mise à jour d'une User
  def update
    @user = User.find(params[:id])
    liste_des_roles_db = Array.new
    liste_des_roles_db = @user.user_roles.collect { |item| item.nom  } if @user.user_roles

    liste_des_roles_client = Array.new
    liste_des_roles_client = params[:roles_name] if  params[:roles_name]

    # Suppresion des rôles
    liste_des_roles_db.each { |role_name_db|
      unless(liste_des_roles_client.include?(role_name_db))
        # suppresion de rôle
        user_role = UserRole.find(:first,:conditions=>"nom = '#{role_name_db}' and user_id = #{@user.id}")
        user_role.delete
      end
    }

    # Ajoute des rôles
    liste_des_roles_client.each{ |nom|
      unless(liste_des_roles_db.include?(nom))
        user_role = UserRole.new
        user_role.user_id = @user.id
        user_role.nom = nom
        user_role.save
      end
    }
    

    if @user.update_attributes(params[:user])
      flash[:notice] = t("GestionUsers.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end

  def delete
      user = User.find(params[:id])
      if user.delete
        flash[:notice] = t("GestionUsers.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionUsers.msg.erreur de suppression")
      end
      redirect_to :action=>:index

  end
  
  #Formulaire d'Ajouter une nouvelle User
  def new
     @user = User.new
  end

# Création de la User
  def create
    user = User.new(params[:user])
    if user.save
      flash[:notice] = t("GestionUsers.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionUsers.msg.erreur_ajouter")
      render :action => :new
    end
  end







  def show
  end

end
