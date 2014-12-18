class ComposantsAtomiques::CmpFormAddSiteController < ApplicationControllerCore
   
  def add

    continue = true; # données utilisateur valide

    # Récuperation de données utilisateur
    @nom_site = params["nom_site"]
    @nom_site = StringManager.string_to_reference(@nom_site) # Virification de Validation de nom de site
    @login = params["login"]
    @mo_de_passe = params["mo_de_passe"]
    @confirm_mot_de_pass = @mo_de_passe
    @email = params["email"]
    @confirm_email =@email

    # viréfication de l'unicité de nom_site ou login
    reference_site_existe  = CmpSite.find(:first, :conditions=>["reference = ?",@nom_site])
    if !reference_site_existe.nil?
       flash[:notice] = t("GestionSites.msg.reference_site_existe")
       continue = false
    end
    # unicité de login
    login_existe = User.find(:first,:conditions=>["login = ?",@login])
    if !login_existe.nil?
       flash[:notice] = t("GestionSites.msg.login_deja_existe")
       continue = false
    end
    # unicité de email
    email_existe = User.find(:first,:conditions=>["email = ?",@email])
    if !email_existe.nil?
       flash[:notice] = t("GestionSites.msg.email_deja_existe")
       continue = false
    end
    
    # Maximale 50 site web existant
    nombre_site = CmpSite.count(:all)
    if nombre_site > 50
      continue = false
       flash[:notice] =  t("GestionSites.msg.creation_de_site_suspendu")
    end


    if  continue     

       # Creation de Compte sur Manarati
        user = User.new()
        user.login = @login
        user.password = @mo_de_passe
        user.password_confirmation = @mo_de_passe
        user.email = @email
        user.nom = ""
        user.prenom = ""
        flash[:notice] = ""
        if user.save

            #Déclaration de site sur Database
            site = CmpSite.new
            site.reference = @nom_site
            site.user_id = user.id
            site.solde = 0;
            site.date_creation = Time.now
            if site.save
              
                # Creation physique de Site web
                creation_site = `bash /srv/sites/script_manager/add_site.sh #{@nom_site}`
                p creation_site
                result=$?.success?
                if result
                      flash[:notice] = t("GestionSites.msg.ajouter_avec_succes") 
                      @result = result
                      @password = @mo_de_passe
                      # Envoi de email au client
                        @message = render_to_string  :partial=>"/emailer/bonjour_sur_manarati",:locals=>{:nom_site=>@nom_site,:login=>@login}
                        Emailer.deliver_contact(@email, "Bienvenue chez Manarati.net !", @message)
                      # Envoi de email au l'admin
                else
                      flash[:notice] =   t("GestionSites.msg.erreur_ajouter") 
                      continue = false
                end

            else
               flash[:notice] =   t("GestionSites.msg.erreur_ajouter")
               continue = false
            end
        else
        flash[:notice]  =   t("GestionUsers.msg.erreur_ajouter")
        continue = false
        end
    end

    if !continue
       add_site
       render :action=>:add_site
    end


   


 

    
  end


  def add_site
     @page = CmpPage.find_by_reference(params[:reference_page])
  end


end
