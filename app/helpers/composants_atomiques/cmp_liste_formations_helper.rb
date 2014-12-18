module ComposantsAtomiques::CmpListeFormationsHelper
  def cmp_liste_formations(composant)
     formations = Formation.find(:all)
     render :partial => "composants_atomiques/cmp_liste_formations/cmp_liste_formations", :locals => { :obj => composant,:formations=>formations }
  end
  def cmp_liste_formations_form(composant)
      render :partial=>"/composants_atomiques/cmp_liste_formation/cmp_liste_formations_form",:locals=>{:composant=>composant}
  end

end
