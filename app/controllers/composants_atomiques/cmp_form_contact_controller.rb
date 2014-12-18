class ComposantsAtomiques::CmpFormContactController < ApplicationControllerCore




   def ajouter_contact
    @nom = params[:nom]
    @prenom = params[:prenom]
    @email = params[:email]
    @message = params[:contact][:message]
    @objet = params[:objet]
    contact = Contact.new
    contact.nom = @nom
    contact.prenom = @prenom
    contact.message = @message
    contact.email = @email
    contact.objet = @objet
    if contact.save
      flash[:notice] = t("GestionContacts.msg.ajouter_avec_succes")
      # Envoi de email a l'administrateur de site
      @message = render_to_string  :partial=>"/emailer/contact",:locals=>{:nom=>@nom,:prenom=>@prenom,:sujet=>@objet,:message=>@message}
      Emailer.deliver_contact("essarraj.fouad@gmail.com", "Contact de Site www.manarati.net", @message)
    @nom = ""
    @prenom = ""
    @email = ""
    @message = ""
    @objet = ""
      page_formulaire_contact
      render :action=>:page_formulaire_contact
    else
      flash[:notice] = t("GestionContacts.msg.erreur_ajouter")
      page_formulaire_contact
      render :action=>:page_formulaire_contact
    end
  end


  def page_formulaire_contact
     @page = CmpPage.find_by_reference(params[:reference_page])
  end

end
