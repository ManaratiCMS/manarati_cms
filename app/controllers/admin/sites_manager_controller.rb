class Admin::SitesManagerController < ApplicationControllerCoreAdmin
  layout "admin"
  def index
    @page.titre = t("GestionSites.Pages.Index.titre")
    @sites = CmpSite.find(:all)
  end
  
  def choix_pocesseur_site
    # Choix de user
    @page = CmpPage.new(:titre=>t("GestionSites.Pages.choix_pocesseur_site.titre"))
    @users = User.find(:all,:conditions=>["(ref_site is NULL or ref_site ='') and  login != ?","admin"])
  end

  def new
     @site = User.find(params[:id])
     @sites = CmpSite.find(:all)
     @packs = CmpPack.find(:all)
  end

# Création de site web
  def create
    site = CmpSite.new(params[:site])
    if site.save
      flash[:notice] = t("GestionSites.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionSites.msg.erreur_ajouter")
      render :action => :choix_pocesseur_site
    end
  end

 
  def edit
    @site = CmpSite.find(params[:id])
  end

  # Mise à jour d'une formation
  def update
    @site = CmpSite.find(params[:id])
    if @site.update_attributes(params[:site])
      flash[:notice] = t("GestionSites.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end
  def send_welcome_email
    site = CmpSite.find(params[:id])
    nom_site = site.reference
    login = site.user.login
    email = site.user.email
    message = render_to_string  :partial=>"/emailer/bonjour_sur_manarati",:locals=>{:nom_site=>nom_site,:login=>login}
   
    if Emailer.deliver_contact(email, "Bienvenue chez Manarati.net !", message)
      flash[:notice] = t("GestionSites.msg.email_envoye_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionSites.msg.erreur_envoie_email_succes")
     redirect_to :action=>:index
    end
  end

  def delete
    site = CmpSite.find(params[:id])

      # Supression  Physique de Site web
      delete_site = `bash /srv/sites/script_manager/delete_site.sh #{site.reference}`
      result=$?.success?
      if result
            # Supresion de Site
            if site.destroy
              flash[:notice] = t("GestionSites.msg.supprimer_avec_succes")
              # Supresion de Compte Membre
              user = User.find(site.user_id)
              if !user.delete
                flash[:notice] = t("GestionUsers.msg.erreur de suppression")
              end
            else
              flash[:notice] = t("GestionSites.msg.erreur de suppression")
            end
      else
        flash[:notice] = "Script : " + t("GestionSites.msg.erreur de suppression")
      end
      redirect_to :action=>:index

  end





end
