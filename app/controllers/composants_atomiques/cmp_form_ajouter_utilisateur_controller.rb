class ComposantsAtomiques::CmpFormAjouterUtilisateurController < ApplicationControllerCore
 # Ajouter un utilisateur
  def ajouter
    @nom = params[:nom]
    @prenom = params[:prenom]
    @email = params[:email]
    @ville= params[:ville]
    @login = params[:login]
    @password = params[:password]

    contact = Utilisateur.new
    contact.nom = @nom
    contact.prenom = @prenom
    contact.email = @email
    contact.ville = @ville
    contact.login = @login
    contact.password = @password

    if contact.save
      flash[:notice] = t("GestionUtilisateurs.msg.ajouter_avec_succes")
      # Envoi de email a l'administrateur de site
      @message = render_to_string  :partial=>"/emailer/contact",:locals=>{:nom=>@nom,:prenom=>@prenom,:sujet=>"Inscription d'un nouveau Utilisateur",:message=>"Nouvelle Utilisateur"}
      Emailer.deliver_contact("essarraj.fouad@gmail.com", "Nouvelle Utilisateur", @message)
    @nom = ""
    @prenom = ""
    @email = ""
    @login = ""
    @password = ""
    @ville = ""
      redirect_to "/bureau/authentication/sign_in"
    else
      flash[:notice] = t("GestionUtilisateurs.msg.erreur_ajouter")
      page_formulaire
      render :action=>:page_formulaire
    end
  end


  def page_formulaire
     @page = CmpPage.find_by_reference(params[:reference_page])
  end

end
