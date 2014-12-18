# Controleur de Composant Atomique Contact
class ComposantsAtomiques::CmpContactController < ApplicationControllerCore

  def ajouter
      page = Membre.new(params[:membre])
      page.save
      
  end

  def ajouter_contact
    
  end


end
