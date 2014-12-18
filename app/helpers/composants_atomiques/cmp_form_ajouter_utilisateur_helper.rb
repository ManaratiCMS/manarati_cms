module ComposantsAtomiques::CmpFormAjouterUtilisateurHelper
  def cmp_form_ajouter_utilisateur(obj)
    render :partial => "composants_atomiques/cmp_form_ajouter_utilisateur/cmp_form_ajouter_utilisateur", :locals => { :obj => obj }
  end

  def cmp_form_ajouter_utilisateur_form(obj)
      render :partial=>"/composants_atomiques/cmp_form_ajouter_utilisateur/cmp_form_ajouter_utilisateur_form",:locals=>{:obj=>obj}
  end
end
