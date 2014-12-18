module ComposantsAtomiques::CmpListePartenairesHelper
  def cmp_liste_partenaires(composant)
     partenaires = PartenaireG2.find(:all)
     render :partial => "composants_atomiques/cmp_liste_partenaires/cmp_liste_partenaires", :locals => { :obj => composant,:partenaires=>partenaires }
  end

  def cmp_liste_partenaires_form(composant)
      render :partial=>"/composants_atomiques/cmp_liste_partenaires/cmp_liste_partenaires_form",:locals=>{:composant=>composant}
  end
end
