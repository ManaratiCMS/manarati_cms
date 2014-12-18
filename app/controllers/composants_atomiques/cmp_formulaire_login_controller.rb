class ComposantsAtomiques::CmpFormulaireLoginController < ApplicationControllerCore
 # Login
  def login
    @login = params[:login]
    @password = params[:password]

    # Recheche de l'utilisation

    
    @login = ""
    @password = ""
    if false

      render_to "/bureau/profile/"
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
